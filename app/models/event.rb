class Event < ApplicationRecord
  FLAGS = {
    French: "🇫🇷",
    English: "🇬🇧",
    Spanish: "🇪🇸",
    Portuguese: "🇵🇹"
  }
  belongs_to :user
  has_many :bookings
  has_many :participants, through: :bookings, source: :user

  validates :title, :category, :address, :description, :date, :language, :capacity, presence: true
  validates :category, inclusion: { in: ["Dinner", "Cooking Class", "Food Tour", "Brunch"] }
  validates :language, inclusion: { in: ["French", "English", "Spanish", "Portuguese"] }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos
end
