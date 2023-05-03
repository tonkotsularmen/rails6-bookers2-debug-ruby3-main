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
end
