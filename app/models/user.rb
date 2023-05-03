class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",  #デフォルトではactive_relationshipモデルを探しに行くのでRelationshipモデルを探しに行ってよと設定する必要がある
                                 foreign_key: "follower_id",  #デフォルトでは{モデル}名_idを探しに行くので設定してあげる
                                   dependent: :destroy
  has_many :followers, through: :active_relationships,
                         source: :followed
  #Userモデル(class)のインスタンスは、followingっていうメソッドを呼び出すことができる。呼び出す時に、through以下とsource以下を活用する。

  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :followeds, through: :passive_relationships,
                        source: :follower

  has_one_attached :profile_image
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def followed_by?(user)
    active_relationships.exists?(followed_id: user.id)
    #active_relationships.find_by(followed_id: user.id).present?
  end
end
