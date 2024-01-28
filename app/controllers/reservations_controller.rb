class ReservationsController < ApplicationController
    def index
        @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
        @reservationsAll = Reservation.all
      end
    
      def new
        @reservation = Reservation.new
        @day = params[:day]
        @time = params[:time]
        @start_time = DateTime.parse("#{@day} #{@time} JST")

      end
    
      def create
        reservation_params = reservation_params_with_start_time
        @reservation = current_user.reservations.build(reservation_params)
      
        if @reservation.save
          redirect_to reservation_path(@reservation.id)
        else
          render :new
        end
      end
 
    
      def show
        @reservation = Reservation.find(params[:id])
      end
      
      def check_reservation(existing_reservations, day, time)
        # 既存の予約から指定された日時の予約を探す
        existing_reservations.any? do |reservation|
          reservation.day == day && reservation.time == time
        end
      end

      private
      def reservation_params
        params.require(:reservation).permit(:day, :time, :other_attributes)
      end
      
      
      def reservation_params_with_start_time
        reservation_params = params.require(:reservation).permit(:day, :time)
        day = reservation_params[:day]
        time = reservation_params[:time]
        start_time = DateTime.parse("#{day} #{time} JST")
        reservation_params.merge(start_time: start_time)
      end
end
