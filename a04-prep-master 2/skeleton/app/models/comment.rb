class Comment < ApplicationRecord
    validates :body, :link_id, :user_id, presence: true

    belongs_to :link
    belongs_to :user
end