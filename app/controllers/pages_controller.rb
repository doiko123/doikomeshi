class PagesController < ApplicationController
  def index

  end

  def sponsored(name:, email:, billing_card:)
    ActiveRecord::Base.transaction do

      # stripe上とDB上両方でcustomerを作成
      customer = Customer.new(name: name, email: email).create_with_stripe!

      card_params = billing_card.permit(billing_card.keys)

      # stripe上とDB上両方でcardを作成
      card = Card.new(customer: customer).
        create_with_stripe!(
          exp_month: card_params[:exp_month], # "11"
          exp_year: card_params[:exp_year], # "22"
          number: card_params[:number], # "5105 1051 0510 5100" or "5105105105105100"
          cvc: card_params[:cvc] # "123"
        )

      # TODO: productのid=5とskuのid=1を削除して、残りの各1つをいずれもid=1に変えたい
      sku = Sku.find(2)
      order = Order.new(sku: sku, customer: customer).create_with_stripe!
    end

    # 処理が正常に完了した場合
    redirect_to action: :thanks
  end

  def thanks; end
end