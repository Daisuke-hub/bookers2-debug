class RelationshipsController < ApplicationController
  def create
    # p "debug"
    user_id = params[:user_id]
    # user = User.find(params[:user_id])
    # relationship = user.active_relationships.new(following_id: current_user.id, follower_id: user_id)
    relationship = Relationship.new(following_id: current_user.id, follower_id: user_id)
    relationship.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    relationship = current_user.active_relationships.where(follower_id: user.id).first
    relationship.destroy
    redirect_to request.referer
  end

  def follows
    @users = current_user.followings
  end

  def followers
    @users = current_user.followers
  end
end
