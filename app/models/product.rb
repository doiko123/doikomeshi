class Product < ApplicationRecord
  before_create :create_stripe_product


  private

  def create_stripe_product
    stripe_product = Stripe::Product.create({name: name})
    self.stripe_id = stripe_product.id
  end
end