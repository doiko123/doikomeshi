class Product < ApplicationRecord

  has_one :sku

  # Stripeの商品を作成し、DBにインサートする
  def create_with_stripe!
    stripe_product = Stripe::Product.create({name: name, type: 'good', shippable: 'false'})
    self.stripe_id = stripe_product.id

    self.save!
    self
  end
end