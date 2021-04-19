class Customer < ApplicationRecord
  before_create :create_stripe_customer

  private

  def create_stripe_customer
    stripe_customer = Stripe::Customer.create({name: name, email: email})
    self.stripe_id = stripe_customer.id
  end
end
