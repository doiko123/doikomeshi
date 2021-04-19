class Customer < ApplicationRecord
  validates :stripe_id, presence: true, unless: Proc.new { |customer| customer.new_record? }
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