class ApplicationController < ActionController::Base

  rescue_from ActionController::RoutingError, with: :rescue404 unless Rails.env.development?

  # 存在しないurlを入力された場合はルーティングエラーを発生し404のページを表示させる
  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  private

  def rescue404(e)
    Rails.logger.info "Rendering 404 with exception: #{e.message}" if e
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
