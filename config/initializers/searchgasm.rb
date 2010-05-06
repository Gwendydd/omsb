Searchgasm::Config.configure do |config|
  config.per_page = 25
end

class IsNotBlank < Searchgasm::Condition::Base
  def to_conditions(value)
    ["#{quoted_table_name}.#{quoted_column_name} !='' " ]
  end
end

Searchgasm::Conditions::Base.register_condition(IsNotBlank)  
