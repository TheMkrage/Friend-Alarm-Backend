class UserAlarmsController < ApplicationController
  before_action :set_user_alarm, only: [:show, :update, :destroy]

  # GET /user_alarms
  def index
    @user_alarms = UserAlarm.all

    render json: @user_alarms
  end

  # GET /user_alarms/1
  def show
    render json: @user_alarm
  end

  # POST /user_alarms
  def create
    potential_exisitng_alarm = UserAlarm.where(owner_id: user_alarm_params[:owner_id], referrer_id: user_alarm_params[:referrer_id], alarm_id: user_alarm_params[:alarm_id]).first
    if potential_exisitng_alarm != nil
      potential_exisitng_alarm.is_secret = user_alarm_params[:is_secret]
      potential_exisitng_alarm.is_high_priority = user_alarm_params[:is_high_priority]
      render json: potential_exisitng_alarm, status: :created
      return
    end
    @user_alarm = UserAlarm.new(user_alarm_params)

    if @user_alarm.save
      render json: @user_alarm, status: :created, location: @user_alarm
    else
      puts @user_alarm.errors.first
      render json: @user_alarm.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_alarms/1
  def update
    if @user_alarm.update(user_alarm_params)
      render json: @user_alarm
    else
      render json: @user_alarm.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_alarms/1
  def destroy
    @user_alarm.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_alarm
      @user_alarm = UserAlarm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_alarm_params
      params.permit(:alarm_id, :owner_id, :referrer_id, :is_secret, :is_high_priority)
    end
end
