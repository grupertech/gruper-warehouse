class Admin::ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def available
    @products = Product.order('created_at desc').where(status: 'available').paginate(:page => params[:page], :per_page => 15)
  end

  def unavailable
    @products = Product.order('created_at desc').where(status: 'unavailable').paginate(:page => params[:page], :per_page => 15)
  end

  def in_review
    @products = Product.order('created_at desc').where(status: 'in review').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @product.save
      redirect_to admin_products_url, notice: 'Success added product'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @product.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @product.update(product_params)
      redirect_to admin_products_url, notice: 'Success updated product'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_url, notice: 'Deleted product'
  end

  private
    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit!
    end
end