class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"  #follower_idはUserのuser_idに紐づいている。
  #デフォルトでモデル名_id（Follower_id）でFollowerモデルを探しにいくので、いや違うよ。Userクラスとfollower_idを紐づけて。
  belongs_to :followed, class_name: "User"  #followed_idはUserのuser_idに紐づいている。
  #デフォルトでモデル名_id（Followed_id）でFollowedモデルを探しにいくので、いや違うよ。Userクラスとfollowed_idを紐づけて。
end
