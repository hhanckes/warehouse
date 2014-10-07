# encoding: UTF-8
class InformationPagesController < ApplicationController
  before_action :set_information_page, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Páginas Informativas", information_pages_path
    
    @information_pages = InformationPage.all
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Páginas Informativas", information_pages_path
    add_breadcrumb @information_page.title, @information_page
    
  end

  def new
    @information_page = InformationPage.new
    1.times { @information_page.information_page_contents.build }
  end

  def edit
  end

  def create
    @information_page = InformationPage.new(information_page_params)
    respond_to do |format|
      if @information_page.save
        format.html { redirect_to @information_page, notice: 'Página informativa creada correctamente.' }
        format.json { render action: 'show', status: :created, location: @information_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @information_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @information_page.update(information_page_params)
        format.html { redirect_to @information_page, notice: 'Página informativa actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @information_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @information_page.destroy
    respond_to do |format|
      format.html { redirect_to information_pages_path }
      format.json { head :no_content }
    end
  end

  private
    def set_information_page
      @information_page = InformationPage.friendly.find(params[:id])
    end

    def information_page_params
      params.require(:information_page).permit(:title, :subtitle, information_page_contents_attributes: [:id, :title, :subtitle, :content, :_destroy])
    end
end
