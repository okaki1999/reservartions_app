class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # ログイン済ユーザーのみにアクセスを許可する
    before_action :authenticate_user!
  
    # deviseコントローラーにストロングパラメータを追加する          
    before_action :configure_permitted_parameters, if: :devise_controller?

    def check_reservation(existing_reservations, day, time)
        # 既存の予約から指定された日時の予約を探す
        existing_reservations.any? do |reservation|
          reservation.day == day && reservation.time == time
        end
    end
  
    protected
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofileのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
    end
  
end
