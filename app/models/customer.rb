class Customer < ApplicationRecord

  has_many: cards

  validates :stripe_id, presence: true
  validates :name, presence: true
  validates :email, presence: true

  def create_with_stripe
    # Stripe顧客を作成する
    stripe_customer = Stripe::Customer.create({name: name, email: email})
    self.stripe_id = stripe_customer.id

    # CustomerをDBにインサートする
    self.save
  end

  def create_with_stripe!
    # Stripe顧客を作成する
    stripe_customer = Stripe::Customer.create({name: name, email: email})
    self.stripe_id = stripe_customer.id

    # CustomerをDBにインサートする
    self.save!
  end
end