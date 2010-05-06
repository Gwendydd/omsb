class AuthorsController < ApplicationController
   before_filter :login_required, :only => [ :index_cat, :new, :create, :edit, :update, :delete, :show_cat ]
   before_filter :check_administrator_role, :only => [:new, :delete]

   def index
     @search = Author.new_search(params[:search])
     [:name_contains, :alias_contains].each { |field| @search.conditions.send("#{field}=", 
         @search.conditions.name_contains) }
     @search.conditions.any = true
     @authors, @authors_count = @search.all, @search.count
   end

   def show
      @author = Author.find(params[:id])
      @author.sources = @author.sources.find(:all, :conditions =>  ["live = ?", true] )
   end

   def new
      @author = Author.new
   end

   def create
      @author = Author.new(params[:author])
      if @author.save
            redirect_to :action => 'index'
            flash[:notice] = "The author has been saved."
      else
            render :action => 'new'
      end
   end

   def edit
      @author = Author.find(params[:id])
   end

   def update
      @author = Author.find(params[:id])
      if @author.update_attributes(params[:author])
         redirect_to :action => 'show', :id => @author
         flash[:notice] = "Changes saved."
      else
         render :action => 'edit'
      end
   end

   def delete
      Author.find(params[:id]).destroy
      redirect_to :action => 'index'
      flash[:notice] = "Author deleted."
   end

end
