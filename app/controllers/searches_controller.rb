class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:word].empty?
      redirect_to controller: :books, action: :index
    end 
    
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end

  def search_result

  end
  
  #模範解答
  #def search
	#	@model = params[:model]
	#	@content = params[:content]
	#	@method = params[:method]
	#	if @model == 'user'
	#		@records = User.search_for(@content, @method)
	#	else
	#		@records = Book.search_for(@content, @method)
	#	end
	#end
	
end
