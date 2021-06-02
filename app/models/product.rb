class Product < ApplicationRecord

  # Stripeの商品を作成し、DBにインサートする
  def create_stripe_product!
    stripe_product = Stripe::Product.create({name: name})
    self.stripe_id = stripe_product.id

    self.save!
    self
  end
end