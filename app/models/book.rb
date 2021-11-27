class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true
    def sort_book(sort)
      if sort[:sort] == "updated_at_asc"
        order("updated_at ASC")
      elsif sort[:sort] == "updated_at_desc"
        order("updated_at DESC")
      end
    end
  scope :sort_books, -> (sort) { order(sort[:sort]) }
  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Favorite.group(:book_id).order(Arel.sql('count(book_id) desc')).pluck(:book_id))
    when 'dislikes'
      return find(Favorite.group(:book_id).order(Arel.sql('count(book_id) asc')).pluck(:book_id))
    end
  end
end
