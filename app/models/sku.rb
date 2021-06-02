class Sku < ApplicationRecord

belongs_to :product

  def create_with_stripe!
    stripe_sku = Stripe::SKU.create({
      price: price,
      currency: 'jpy',
      inventory: {type: 'infinite'},
      product: product.stripe_id
    })

    self.stripe_id = stripe_sku.id

    self.save!
    self
  end
end
