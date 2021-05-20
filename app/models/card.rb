class Card < ApplicationRecord

  belongs_to: customer

  validates :stripe_id, presence: true
  validates :last4, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :brand, presence: true
end
