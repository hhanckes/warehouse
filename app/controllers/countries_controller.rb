# encoding: UTF-8
class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Países", countries_path
    
    @countries = Country.all
    
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Países", countries_path
    add_breadcrumb @country.name, @country
    
  end

  def new
    @country = Country.new
    1.times { @country.areas.build }
  end

  def edit
  end

  def create
    @country = Country.new(country_params)
    
    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'País creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @country }
      else
        format.html { render action: 'new' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'País actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_path }
      format.json { head :no_content }
    end
    
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, areas_attributes: [:id, :name, :_destroy])
    end
end
