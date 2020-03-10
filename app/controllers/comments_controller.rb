class CommentsController < ApplicationController
    before_action :correct_comment_user, only: [:destroy]

    def create
        @book = Book.find(params[:book_id])
        comment = Comment.new(comment_params)
        comment.user_id = current_user.id
        comment.book_id = @book.id
        if comment.save
          redirect_to book_path(@book), notice: "Saccessfully Commented"
        else
	      @comments = @book.comments
          @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
          @user = current_user
          session[:favorite] = "index"
          @comment = comment
          render template: "books/show"
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        @book = Book.find(params[:book_id])
        redirect_to book_path(@book), notice: "Saccessfully Deleted"
    end

    private
    def comment_params
        params.require(:comment).permit(:comment)
    end

    def correct_comment_user
        comment = Comment.find(params[:id])
        if comment.user_id != current_user.id
            book = Book.find(params[:book_id])
            redirect_to book_path(book)
        end
    end
end
