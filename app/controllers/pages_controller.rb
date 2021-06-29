class PagesController < ApplicationController
  def index; end

  def sponsored(name:, email:, message:, billing_card:)
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
      sku = Sku.first
      order = Order.new(sku: sku, customer: customer).create_with_stripe!
    end

    # slack通知する内容
    msg = [
      "お名前： #{name}",
      "メールアドレス： #{email}",
      "メッセージ： #{message}"
    ]

    # slackへ通知を送信
    SlackNotification.new.send(msg.join("\n"))

    # 処理が正常に完了したらthanksページへ遷移
    redirect_to action: :thanks

  rescue Stripe::CardError => e
    # カードに関するエラー
    Rails.logger.error e
    Rails.logger.error e.class
    Rails.logger.error e.backtrace.join("\n")
    flash[:alert] = '【入力内容をご確認ください】カードについてエラーとなりました。入力内容がお間違いないかご確認頂き、再度エラーになる場合は別のカードでお試し下さい。'
    redirect_to action: :index
  rescue Stripe::InvalidRequestError => e
    # 無効なパラメータが渡された場合のエラー（パラメータが存在しない＝未入力の場合など）
    Rails.logger.error e
    Rails.logger.error e.class
    Rails.logger.error e.backtrace.join("\n")
    flash[:alert] = '【入力内容をご確認ください】入力内容についてエラーとなりました。入力内容がお間違いないかご確認の上、修正・お進み願います。'
    redirect_to action: :index
  rescue Stripe::StripeError => e
    # その他Stripeに関する接続・認証・一般的なエラー
    Rails.logger.error e
    Rails.logger.error e.class
    Rails.logger.error e.backtrace.join("\n")
    flash[:alert] = '【時間を空けてお試しください】現在決済システムにて問題が発生しておりカードをご登録いただけません。恐れ入りますが時間をあけて再度お試しください。'
    redirect_to action: :index
  rescue StandardError => e
    # otomoni側のエラー
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    flash[:alert] = '【時間を空けてお試しください】システムで問題が発生しておりカードをご登録いただけません。恐れ入りますが時間をあけて再度お試しください。'
    redirect_to action: :index
  end

  def thanks; end
end