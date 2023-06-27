class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]
  before_action :set_nearest_stations, only: %i[ show edit update ]

  # GET /properties or /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1 or /properties/1.json
  def show;
    @neares_stations = @property.nearest_stations
  end

  # GET /properties/new
  def new
    @property = Property.new
    2. times { @property.nearest_stations.build }
  end

  # GET /properties/1/edit
  def edit;
    @property.nearest_stations.build
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @property.save
          format.html { redirect_to @property, notice: "物件情報が作成されました" }
          format.json { render :show, status: :created, location: @property }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirm
    @property = Property.new(property_params)
    render :new if @property.invalid?
  end
  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "物件情報の編集が完了しました" }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "物件情報が削除されました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_property
      @property = Property.find(params[:id])
  end

  def set_nearest_stations
    @neares_stations = @property.nearest_stations
  end
    # Only allow a list of trusted parameters through.
  def property_params
    params.require(:property).permit(:property, :rent, :address, :building_age, :remarks,
                                    nearest_stations_attributes:[:id, :title, :name_of_railway, :station_name, :how_many_minuites_walk])
  end
end
