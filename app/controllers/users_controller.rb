class UsersController < ApplicationController
	before_action :baria_user, only: [:update, :edit]
	before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
	if @users = session[:word_params]
		@users = User.method_select(session[:method_params],session[:word_params])
	else
		@users = User.all
	end
	# session[:word_params].clear  .nilだと空の値が残るがdeleteだとsession自体が削除される
	session.delete(:method_params)
	session.delete(:word_params)
	@user = current_user
	@book = Book.new
  end

  def edit
	  @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
	  if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
	  else
  		render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
#    def baria_user
#   	unless params[:id].to_i == current_user.id
#   		redirect_to user_path(current_user)
#   	end
#    end
   def baria_user
	user = User.find(params[:id])
	if user != current_user
		redirect_to user_path(current_user)
	end
 end
 

end
