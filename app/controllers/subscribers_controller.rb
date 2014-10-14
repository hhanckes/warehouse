# encoding: UTF-8
class SubscribersController < ApplicationController
  before_action :authenticate_user!, :redirect_unless_is_god, except: [:create]
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Suscriptores", subscribers_path
    
    @subscribers = Subscriber.all
  end

  def edit
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    
    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to root_path, notice: '¡Bienvenido! Te has suscrito correctamente.' }
      else
        format.html { redirect_to root_path, alert: 'Correo no puede estar en blanco y debe ser válido' }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscriber.update(subscriber_params)
        format.html { redirect_to subscribers_path, notice: @subscriber.email+' quedó OK' }
      else
        format.html { redirect_to subscribers_path, alert: @subscriber.email+' no quedó OK' }
      end
    end
  end

  def destroy
    email = @subscriber.email
    @subscriber.destroy
    redirect_to subscribers_path, notice: email+' eliminado quedó OK'
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
