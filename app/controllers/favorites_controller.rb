class FavoritesController < ApplicationController

    def create
      @book = Book.find(params[:book_id])
      favorite = Favorite.new(user_id: current_user.id, book_id: @book.id)
      favorite.save
      if session[:favorite] == "show"
        redirect_to book_path(@book)
      else
        redirect_to books_path
      end
    end

    def destroy
      @book = Book.find(params[:book_id])
      favorite = Favorite.where(user_id: current_user.id, book_id: @book.id).first
      favorite.destroy
      if session[:favorite] == "show"
        redirect_to book_path(@book)
      else
        redirect_to books_path
      end
    end

end
