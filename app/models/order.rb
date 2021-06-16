class Order < ApplicationRecord

belongs_to :customer
belongs_to :sku

  def create_with_stripe!
    stripe_order = Stripe::Order.create({
      currency: 'jpy',
      items: [{type: 'sku', parent: sku.stripe_id}],
      customer: customer.stripe_id
    })

    Stripe::Order.pay(
      stripe_order.id,
      { customer: customer.stripe_id },
    )

    self.stripe_id = stripe_order.id

    self.save!
    self
  end
end