class Customer < ApplicationRecord
  before_create :create_stripe_customer
  validates :stripe_id, presence: true, unless: Proc.new { |customer| customer.new_record? }
  validates :name, presence: true
  validates :email, presence: true

  private

  def create_stripe_customer
    stripe_customer = Stripe::Customer.create({name: name, email: email})
    self.stripe_id = stripe_customer.id
  end
end
