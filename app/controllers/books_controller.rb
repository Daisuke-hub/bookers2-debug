class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
	  @book = Book.find(params[:id])
	  @user = @book.user
	  @comment = Comment.new
	  @comments = @book.comments
	#   @comment_user = @book.comments.includes(:user).first
	  session[:favorite] = "show"
  end

  def index
	if @books = session[:word_params]
		@books = Book.method_select(session[:method_params],session[:word_params])
	else
		@books = Book.all
	end
	session.delete(:word_params)
	@book = Book.new
	@user = current_user
	session[:favorite] = "index"
  end

  def create
	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
	@book.user = current_user
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
		@books = Book.all
		@user = current_user
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def correct_user
	book = Book.find(params[:id])
	user = book.user
	if user != current_user
		redirect_to books_path
	end
  end
end
