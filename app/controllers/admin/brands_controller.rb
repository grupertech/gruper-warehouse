class Admin::BrandsController < ApplicationController
  before_action :find_brand, except: [:index, :new, :create]

  def index
    @brands = Brand.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    @brand.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @brand.save
      redirect_to admin_brands_url, notice: 'Success added brand'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @brand.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @brand.update(brand_params)
      redirect_to admin_brands_url, notice: 'Success updated brand'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @brand.destroy
    redirect_to admin_brands_url, notice: 'Deleted brand'
  end

  private
    def find_brand
      @brand = Brand.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit!
    end
end