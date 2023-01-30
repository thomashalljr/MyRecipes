class Message < ApplicationRecord
  belongs_to :chef

  validates :content, presence: true

  def self.most_recent
    order(created_at: :asc).last(20)
  end
end
