class Card < ApplicationRecord

  belongs_to :customer

  validates :stripe_id, presence: true
  validates :last4, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :brand, presence: true

  # Stripe顧客を作成し、customerをDBにインサートする
  def create_with_stripe!(
    exp_month:, # "11"
    exp_year:, # "22"
    number:, # "5105 1051 0510 5100" or "5105105105105100"
    cvc: # "123"
  )
    # カードのトークンを取得
    stripe_card = Stripe::Token.create({
      card: {
        number: number,
        exp_month: exp_month,
        exp_year: exp_year,
        cvc: cvc,
      },
    })

    # Stripeから持ってきたトークンでデータを作る
    card = Stripe::Customer.create_source(
      self.customer.stripe_id,
      {source: stripe_card.id},
    )

    # インスタンスに属性を追加し、DBにカードをインサートする
    self.attributes = {
      stripe_id: card.id,
      last4: card.last4,
      exp_month: card.exp_month,
      exp_year: card.exp_year,
      brand: card.brand,
    }

    self.save!
  end
end
