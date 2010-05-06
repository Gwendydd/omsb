class SourcesController < ApplicationController
   before_filter :login_required, :only => [ :new, :create, :edit, :update, :delete, :show_cat ]

   def index
     @search = Source.new_search(params[:search])
     if params[:search]
       @sources, @sources_count = @search.all, @search.count
     end
   end

   def show
      @source = Source.find(params[:id])
   end

   def details
      @sources = Source.find(params[:selected])
   end

   def show_cat
      @source = Source.find(params[:id])
   end

   def new
      @source = Source.new
      @source.countries.build
      @source.subjects.build
      @source.languages.build
      @source.types.build
      @source.authorships.build
   end

   def create
      @source = Source.new(params[:source])
      @source.user_id = @current_user.id      
      if @source.save
            redirect_to :action => 'show_cat', :id => @source
            flash[:notice] = "Your record has been saved."
      else
            render :action => 'new'
      end
   end

   def edit
      @source = Source.find(params[:id])
   end

   def update
      params[:source][:existing_country_attributes] ||= {}
      params[:source][:existing_language_attributes] ||= {}
      params[:source][:existing_type_attributes] ||= {}
      params[:source][:existing_subject_attributes] ||= {}
      params[:source][:existing_authorship_attributes] ||= {}

      @source = Source.find(params[:id])
      if @source.update_attributes(params[:source])
         redirect_to :action => 'show_cat', :id => @source
         flash[:notice] = "Your changes have been saved."
      else
         render :action => 'edit'
      end
   end

   def delete
      Source.find(params[:id]).destroy
      redirect_to :action => 'cataloger', :id => 'all'
   end

   def cataloger
   end

end
