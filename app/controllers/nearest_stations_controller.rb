class NearestStationsController < ApplicationController
  before_action :set_nearest_station, only: %i[ show edit update destroy ]

  def index
    @nearest_stations = NearestStation.all
  end

  def show;
  end

  def new
    @nearest_station = NearestStation.new
    @nearest_station.properties.build
  end

  def edit;
  end

  def create
    @nearest_station = NearestStation.new(nearest_station_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @nearest_station.save
          format.html { redirect_to @nearest_station, notice: "物件情報が作成されました" }
          format.json { render :show, status: :created, location: @nearest_station }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @nearest_station.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirm
    @nearest_station = NearestStation.new(nearest_station_params)
    render :new if @nearest_station.invalid?
  end

  def update
    respond_to do |format|
      if @nearest_station.update(nearest_station_params)
        format.html { redirect_to @nearest_station, notice: "物件情報の編集が完了しました" }
        format.json { render :show, status: :ok, location: @nearest_station }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nearest_station.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @nearest_station.destroy
    respond_to do |format|
      format.html { redirect_to nearest_stations_url, notice: "物件情報が削除されました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_nearest_station
    @nearest_station = NearestStation.find(params[:id])
  end

  def nearest_station_params
    params.require(:nearest_station).permit(:title, :name_of_railway, :station_name, :how_many_minuites_walk,
                                            properties_attributes:[:id, :property, :rent, :address, :building_age, :remarks])
  end
end