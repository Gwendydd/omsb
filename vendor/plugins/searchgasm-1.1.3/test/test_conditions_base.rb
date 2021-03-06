require File.dirname(__FILE__) + '/test_helper.rb'

class TestConditionsBase < Test::Unit::TestCase
  fixtures :accounts, :users, :orders
  
  def setup
    setup_db
    load_fixtures
  end
  
  def teardown
    teardown_db
  end
  
  def test_register_conditions
    Searchgasm::Conditions::Base.register_condition(Searchgasm::Condition::Keywords)
    assert [Searchgasm::Condition::Keywords], Searchgasm::Conditions::Base.conditions
    
    Searchgasm::Conditions::Base.register_condition(Searchgasm::Condition::Contains)
    assert [Searchgasm::Condition::Keywords, Searchgasm::Condition::Contains], Searchgasm::Conditions::Base.conditions
    
  end
  
  def test_initialize
    conditions = Account.new_conditions(:name_contains => "Binary")
    assert_equal conditions.klass, Account
    assert_equal conditions.name_contains, "Binary"
  end
  
  def test_conditions_added
    # test to make sure all of the proper methods were add, testing condition_names basically
  end
  
  def test_setting_conditions
    [Account, User, Order].each do |klass|
      conditions = klass.new_conditions
      conditions.class.condition_names.each do |condition_name|
        conditions.send("#{condition_name}=", 1)
        assert_equal 1, conditions.send(condition_name)
      end
    end
  end
  
  def test_accessible_protected_conditions
    Account.conditions_accessible << :name_contains
    conditions = Account.new_conditions
    conditions.conditions = {:created_after => Time.now, :name_contains => "Binary"}
    assert({:name_contains => "Binary"}, conditions.conditions)
    Account.send(:write_inheritable_attribute, :conditions_accessible, nil)
    
    Account.conditions_protected << :name_contains
    conditions = Account.new_conditions
    now = Time.now
    conditions.conditions = {:created_after => now, :name_contains => "Binary"}
    assert({:created_after => now}, conditions.conditions)
    Account.send(:write_inheritable_attribute, :conditions_protected, nil)
  end
  
  def test_assert_valid_values
    conditions = User.new_conditions
    assert_raise(ArgumentError) { conditions.conditions = {:unknown => "blah"} }
    assert_nothing_raised { conditions.conditions = {:first_name => "blah"} }
    assert_nothing_raised { conditions.conditions = {:first_name_contains => "blah"} }
  end
  
  def test_setting_associations
    conditions = Account.new_conditions(:users => {:first_name_like => "Ben"})
    assert_equal conditions.users.first_name_like, "Ben"
    
    conditions.users.last_name_begins_with = "Ben"
    assert_equal conditions.users.last_name_begins_with, "Ben"
  end
  
  def test_joins
    conditions = Account.new_conditions
    assert_equal conditions.joins, nil
    
    conditions.name_like = "Binary"
    assert_equal conditions.joins, nil
    
    conditions.users.first_name_like = "Ben"
    assert_equal conditions.joins, :users
    
    conditions.users.orders.description_like = "apple"
    assert_equal conditions.joins, {:users => :orders} 
  end
  
  def test_objects
    conditions = Account.new_conditions
    assert_equal conditions.send(:objects), []
    
    conditions.name_contains = "Binary"
    assert_equal conditions.send(:objects).size, 1
    
    conditions.users.first_name_contains = "Ben"
    assert_equal conditions.send(:objects).size, 2
  end
  
  def test_reset
    conditions = Account.new_conditions
    
    conditions.name_contains = "Binary"
    assert_equal 1, conditions.send(:objects).size
    
    conditions.reset_name_contains!
    assert_equal [], conditions.send(:objects)
    
    conditions.users.first_name_like = "Ben"
    assert_equal 1, conditions.send(:objects).size
    
    conditions.reset_users!
    assert_equal [], conditions.send(:objects)
    
    conditions.name_begins_with ="Binary"
    conditions.users.orders.total_gt = 200
    assert_equal 2, conditions.send(:objects).size
    
    conditions.reset_name_begins_with!
    assert_equal 1, conditions.send(:objects).size
    
    conditions.reset_users!
    assert_equal [], conditions.send(:objects)
  end
  
  def test_sanitize
    conditions = Account.new_conditions
    conditions.name_contains = "Binary"
    conditions.id_gt = 5
    now = Time.now
    conditions.created_after = now
    assert_equal conditions.sanitize, ["(\"accounts\".\"name\" LIKE ?) AND (\"accounts\".\"id\" > ?) AND (\"accounts\".\"created_at\" > ?)", "%Binary%", 5, now]
    
    # test out associations
    conditions.users.first_name_like = "Ben"
    conditions.users.id_gt = 10
    conditions.users.orders.total_lt = 500
    assert_equal conditions.sanitize, ["(\"accounts\".\"name\" LIKE ?) AND (\"accounts\".\"id\" > ?) AND (\"accounts\".\"created_at\" > ?) AND ((\"users\".\"first_name\" LIKE ?) AND (\"users\".\"id\" > ?) AND (\"orders\".\"total\" < ?))", "%Binary%", 5, now, "%Ben%", 10, 500]
  end
  
  def test_conditions
    conditions = Account.new_conditions!
    now = Time.now
    v = {:name_contains => "Binary", :created_at_greater_than => now}
    conditions.conditions = v
    assert_equal v, conditions.conditions
    
    sql = "id in (1,2,3,4)"
    conditions.conditions = sql
    assert_equal sql, conditions.conditions
    
    v2 = {:id_less_than => 5, :name_begins_with => "Beginning of string"}
    conditions.conditions = v2
    assert_equal v2, conditions.conditions
    
    v = {:name_contains => "Binary", :created_at_greater_than => now}
    conditions.conditions = v
    assert_equal v2.merge(v), conditions.conditions
    
    sql2 = "id > 5 and name = 'Test'"
    conditions.conditions = sql2
    assert_equal sql2, conditions.conditions
    
    conditions.name_contains = "awesome"
    assert_equal({:name_contains => "awesome"}, conditions.conditions)
  end
  
  def test_searching
    conditions = Account.new_conditions
    conditions.name_contains = "Binary"
    assert_equal Account.find(1, 3), conditions.all
    assert_equal Account.find(1, 3), conditions.find(:all)
    assert_equal Account.find(1), conditions.first
    assert_equal Account.find(1), conditions.find(:first)
    assert_equal 2, conditions.average('id')
    assert_equal 2, conditions.calculate(:avg, 'id')
    assert_equal 3, conditions.calculate(:max, 'id')
    assert_equal 2, conditions.count
    assert_equal 3, conditions.maximum('id')
    assert_equal 1, conditions.minimum('id')
    assert_equal 4, conditions.sum('id')
  end
  
  def test_any
    conditions = Account.new_conditions
    conditions.name_contains = "Binary"
    assert_equal Account.find(1, 3), conditions.all
    conditions.id = 1
    assert_equal [Account.find(1)], conditions.all
    conditions.any = true
    assert_equal Account.find(1, 3), conditions.all
    conditions.any = false
    assert_equal [Account.find(1)], conditions.all
  end
  
  def test_ignoring_blanks
    conditions = Account.new_conditions(:name => "", :created_after => nil)
    assert_equal(nil, conditions.conditions)
    conditions.name = ""
    assert_equal({:name_equals => ""}, conditions.conditions)
    conditions.created_after = ""
    assert_equal({:name_equals => ""}, conditions.conditions)
  end
  
  def test_inspect
    conditions = Account.new_conditions
    assert_nothing_raised { conditions.inspect }
  end
end
