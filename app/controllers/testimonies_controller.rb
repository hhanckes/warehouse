class TestimoniesController < ApplicationController
  before_action :set_testimony, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Testimonios", testimonies_path
    
    @testimonies = Testimony.all
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Testimonios", testimonies_path
    add_breadcrumb @testimony.name, @testimony
    
  end

  def new
    @testimony = Testimony.new
  end

  def edit
  end

  def create
    @testimony = Testimony.new(testimony_params)
    
    respond_to do |format|
      if @testimony.save
        format.html { redirect_to @testimony, notice: 'Testimonio creado correctamente.' }
        format.json { render action: 'show', status: :created, location: @testimony }
      else
        format.html { render action: 'new' }
        format.json { render json: @testimony.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @testimony.update(testimony_params)
        format.html { redirect_to @testimony, notice: 'Testimonio actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @testimony.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @testimony.destroy
    respond_to do |format|
      format.html { redirect_to testimonies_path }
      format.json { head :no_content }
    end
  end

  private
    def set_testimony
      @testimony = Testimony.find(params[:id])
    end

    def testimony_params
      params.require(:testimony).permit(:name, :title, :content, :photo)
    end
end
