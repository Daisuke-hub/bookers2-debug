class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #==========================自分がフォローしているユーザとの関連============================================================================== 
  # Relationshipsモデルに対してforein_keyをfollowing_user_idとしたアソシエーションを定義する(アソシエーションを結んだモデルをactive_relationshipsとする)
  # belongs_to(has_many) 変更したい親モデル名, class_name: "元々の親モデル名"
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # followingのときはfollowerの情報を集める
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

end

# belongs_to :user
# belongs_to :following, class_name: "User" 
# belongs_to :follower, class_name: "User" 
