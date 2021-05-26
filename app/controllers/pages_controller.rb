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

  rescue Stripe::CardError => e
    # カードが使用できない場合のエラー（有効期限切れ等）
    flash[:alert] = '【別のカードでお試しください】上限金額・期限などの理由によりカードがご利用になれませんでした。別のカードにて入力願います。'
    redirect_to action: :index
  rescue Stripe::InvalidRequestError => e
    # 無効なパラメータが渡された場合のエラー（パラメータが存在しない＝未入力の場合など）
    flash[:alert] = '【入力内容をご確認ください】入力内容についてエラーとなりました。入力内容がお間違いないかご確認の上、修正・お進み願います。'
    redirect_to action: :index
  rescue Stripe::StripeError => e
    # その他Stripeに関する接続・認証・一般的なエラー
    flash[:alert] = '【時間を空けてお試しください】現在決済システムにて問題が発生しておりお申込いただけません。恐れ入りますが時間をあけて当ページよりお申し込み願います。'
    redirect_to action: :index
  rescue StandardError => e
    # どいこメシ側のエラー
    flash[:alert] = '【時間を空けてお試しください】現在システムにて問題が発生しておりお申込いただけません。恐れ入りますが時間をあけて当ページよりお申し込み願います。'
    redirect_to action: :index
  end

  def thanks; end
end