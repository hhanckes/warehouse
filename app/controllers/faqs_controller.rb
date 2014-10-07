# encoding: UTF-8
class FaqsController < ApplicationController
  before_action :set_faq, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Preguntas Frecuentes", faqs_path
    
    @faqs = Faq.all
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Preguntas Frecuentes", faqs_path
    add_breadcrumb @faq.question, @faq
  end

  def new
    @faq = Faq.new
  end

  def edit
  end

  def create
    @faq = Faq.new(faq_params)
    respond_to do |format|
      if @faq.save
        format.html { redirect_to @faq, notice: 'Pregunta Frecuente creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @faq }
      else
        format.html { render action: 'new' }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to @faq, notice: 'Sección actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to faqs_path }
      format.json { head :no_content }
    end
    
  end

  private
    def set_faq
      @faq = Faq.find(params[:id])
    end

    def faq_params
      params.require(:faq).permit(:faq_section_id, :question, :answer)
    end
end
