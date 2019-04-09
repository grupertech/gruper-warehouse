class Admin::CouriersController < ApplicationController
  before_action :find_courier, except: [:index, :new, :create]

  def index
    @couriers = Courier.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @courier = Courier.new
  end

  def create
    @courier = Courier.new(courier_params)
    @courier.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @courier.save
      redirect_to admin_couriers_url, notice: 'Success added courier'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @courier.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @courier.update(courier_params)
      redirect_to admin_couriers_url, notice: 'Success updated courier'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @courier.destroy
    redirect_to admin_couriers_url, notice: 'Deleted courier'
  end

  private
    def find_courier
      @courier = Courier.find(params[:id])
    end

    def courier_params
      params.require(:courier).permit!
    end
end