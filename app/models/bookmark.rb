class Bookmark < ApplicationRecord
  belongs_to :list
  belongs_to :movie

  validates :movie_id, uniqueness: { scope: :list_id, message: "is already bookmarked in this list" }
  validates :comment, presence: true, length: { minimum: 6}
end
