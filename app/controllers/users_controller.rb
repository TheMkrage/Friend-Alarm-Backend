class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :alarms, :schedule_alarm, :unschedule_alarm]

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /search
  def search
    where_clause = "lower(username) LIKE '%" << params[:query].downcase << "%'"
    @users = User.where(where_clause)
    render json: @users
  end

  # GET /users/:id/alarms
  def alarms
    render json: @user.alarms
  end

  # POST /users/:id/schedule
  def schedule_alarm
    @user.alarm_time = schedule_alarm_params[:time]
    @user.save
    alarm = Alarm.find_by(id: schedule_alarm_params[:alarm_id])
    AlarmJob.set(wait_until: Time.parse(schedule_alarm_params[:time])).perform_later @user, alarm
    puts "Alarm Set"
    render json: true
  end

  # DELETE /users/:id/schedule
  def unschedule_alarm
    @user.alarm_time = nil
    @user.save
    render json: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :facebook_connection, :apn_token)
    end

    def schedule_alarm_params
      params.permit(:id, :alarm_id, :time)
    end
end
