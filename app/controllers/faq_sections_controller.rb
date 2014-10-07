class FaqSectionsController < ApplicationController
  before_action :set_faq_section, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Secciones de las Preguntas Frecuentes", faq_sections_path
    
    @faq_sections = FaqSection.all
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Secciones de las Preguntas Frecuentes", faq_sections_path
    add_breadcrumb @faq_section.name, @faq_section
    
  end

  def new
    @faq_section = FaqSection.new
    
  end

  def edit
  end

  def create
    @faq_section = FaqSection.new(faq_section_params)
    
    respond_to do |format|
      if @faq_section.save
        format.html { redirect_to @faq_section, notice: 'Sección creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @faq_section }
      else
        format.html { render action: 'new' }
        format.json { render json: @faq_section.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def update
    respond_to do |format|
      if @faq_section.update(faq_section_params)
        format.html { redirect_to @faq_section, notice: 'Sección actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @faq_section.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def destroy
    @faq_section.destroy
    respond_to do |format|
      format.html { redirect_to faq_sections_path }
      format.json { head :no_content }
    end
  end

  private
    def set_faq_section
      @faq_section = FaqSection.find(params[:id])
    end

    def faq_section_params
      params.require(:faq_section).permit(:name, :description)
    end
end
