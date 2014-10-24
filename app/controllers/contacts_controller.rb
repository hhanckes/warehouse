# encoding: UTF-8
class ContactsController < ApplicationController
  before_action :authenticate_user!, :redirect_unless_is_god, except: [:new, :create]
  before_action :set_contact, only: [:show]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Contactos", contacts_path
    
    @contacts = Contact.all.order 'created_at DESC'
  end

  def show
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Contactos", contacts_path
    add_breadcrumb "Contacto de "+@contact.name, @contact
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to new_contact_path, notice: '¡Mensaje enviado exitosamente!' }
        format.json { render action: 'show', status: :created, location: @country }
      else
        format.html { render action: 'new' }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :contact_type, :content)
    end
end
