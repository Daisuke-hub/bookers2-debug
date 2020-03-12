class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #==========================自分がフォローしているユーザとの関連============================================================================== 
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # =====================================================================================================================================

  # =========================自分がフォローされているユーザとの関連============================================================================
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # =====================================================================================================================================

  attachment :profile_image

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  def followed?(user)
    passive_relationships.where(following_id: user.id).exists?
  end

  def self.method_select(method,word)
    if method == "forward_match"
        @users = User.where("name LIKE ?","#{word}%")
    elsif method == "backward_match"
        @users = User.where("name LIKE ?","%#{word}")
    elsif method == "perfect_match"
        @users = User.where("name LIKE ?","#{word}")
    elsif method == "partial_match"
        @users = User.where("name LIKE ?","%#{word}%")
    else
        @users = User.all
    end
  end


end

# belongs_to :user
# belongs_to :following, class_name: "User" 
# belongs_to :follower, class_name: "User" 
