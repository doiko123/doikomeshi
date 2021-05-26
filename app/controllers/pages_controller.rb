class PagesController < ApplicationController
  def index

  end

  def sponsored(name:, email:, billing_card:)
    ActiveRecord::Base.transaction do

      customer = Customer.new(name: name, email: email)
      # stripe上とDB上両方でcustomerを作成
      customer.create_with_stripe!

      card = Card.new(customer: customer)
      card_params = billing_card.permit(billing_card.keys)


      # binding.pry

      # stripe上とDB上両方でcardを作成
      card.create_with_stripe!(
        exp_month: card_params[:exp_month], # "11"
        exp_year: card_params[:exp_year], # "22"
        number: card_params[:number], # "5105 1051 0510 5100" or "5105105105105100"
        cvc: card_params[:cvc] # "123"
      )
    end

    # 処理が正常に完了した場合
    redirect_to action: :thanks
  end

  def thanks; end
end