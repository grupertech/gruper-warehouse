class Admin::VendorsController < ApplicationController
  before_action :find_vendor, except: [:index, :new, :create]

  def index
    @vendors = Vendor.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @payments = Payment.where(vendor_id: @vendor.id)
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    @vendor.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @vendor.save
      redirect_to admin_vendors_url, notice: 'Success added vendor'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @vendor.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @vendor.update(vendor_params)
      redirect_to admin_vendors_url, notice: 'Success updated vendor'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @vendor.destroy
    redirect_to admin_vendors_url, notice: 'Deleted vendor'
  end

  private
    def find_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params.require(:vendor).permit!
    end
end