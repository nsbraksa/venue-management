class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create,
                                            :update, :destroy,
                                            :room_availability,
                                            :rooms_availability]
  before_action :set_room, only: [:show, :edit, :update, :destroy, :room_availability]
  before_action :datify, only: [:room_availability, :rooms_availability]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show; end

  # GET /rooms/new
  def new
    @user = current_user
    @room = @user.rooms.new
  end

  # GET /rooms/1/edit
  def edit
    @user = current_user
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id

    respond_to do |format|
      if @room.save
        format.html { redirect_to user_room_url(current_user, @room), notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to user_room_url(current_user, @room), notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.bookings.destroy_all
    @room.destroy
    respond_to do |format|
      format.html { redirect_to user_rooms_url(current_user), notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def room_availability
    if @start_check > @end_check
      redirect_to user_room_url(current_user, @room), alert: "Start_date must be before End_date."
    else
      if @room.available(@start_check, @end_check)
        redirect_to user_room_url(current_user, @room), notice: 'Room available'
      else
        redirect_to user_room_url(current_user, @room), alert: 'Room not available'
      end
    end
  end

  def rooms_availability
    if @start_check > @end_check
      redirect_to user_room_url(current_user, @room), alert: "Start_date must be before End_date."
    else
      rooms = current_user.rooms
      @available_rooms = []
      rooms.each do |room|
        @available_rooms << room if room.available(@start_check, @end_check)
      end
      @rooms = Room.all
      render 'index'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:name, :user_id)
  end

  def datify(start_param = params[:start_check], end_param= params[:end_check])
    @start_check = Time.utc(start_param['year'], start_param['month'], start_param['day'], start_param['hour'], start_param['minute'])
    @end_check = Time.utc(end_param['year'], end_param['month'], end_param['day'], end_param['hour'], end_param['minute'])
  end
end
