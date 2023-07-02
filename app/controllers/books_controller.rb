class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
    @book_comment = BookComment.new
    unless ReadCount.find_by(user_id: current_user.id, book_id: @book.id)
      read_count = ReadCount.new(book_id: @book.id, user_id: current_user.id)
      # ReadCountを新しく作成し、book_idに取得してきた本のid、user_idにcurrent_userのidを入力
      read_count.save
    end
  end

  def index
    @book = Book.new#新規投稿フォーム用の変数
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end



  private

  def book_params#データベースに保存していいものを許可するメソッド
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
