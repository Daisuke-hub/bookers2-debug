class FavoritesController < ApplicationController

    def create
        favorite = Favorite.new
        favorite.book_id = params[:book_id]
        # book = Book.find(params[:book_id])
        # favorite.user_id = book.user_id
        favorite.user_id = current_user.id
        favorite.save
        # redirect_to show
        @book = Book.find(params[:book_id])
        @user = @book.user
        favorites = @book.favorites
        @favorite = Favorite.where(user_id: current_user.id, book_id: @book).first
        redirect_to book_path(@book)
    end

    def destroy
        favorite = Favorite.find(params[:id])
        favorite.destroy
        # redirect_to show
        @book = Book.find(params[:book_id])
        @user = @book.user
        favorites = @book.favorites
        @favorite = Favorite.where(user_id: current_user.id, book_id: @book).first
        redirect_to book_path(@book)
    end

    # private
    # def favorite_params
    # params.require(:favorite).permit(:favorite, :user_id, :book_id)
    # end
end
