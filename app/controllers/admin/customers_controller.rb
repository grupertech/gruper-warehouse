class Admin::CustomersController < ApplicationController
  before_action :find_customer, except: [:index, :new, :create]

  def index
    @customers = Customer.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @invoices = Invoice.where(customer_id: @customer.id)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @customer.save
      redirect_to admin_customers_url, notice: 'Success added customer'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @customer.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @customer.update(customer_params)
      redirect_to admin_customers_url, notice: 'Success updated customer'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @customer.destroy
    redirect_to admin_customers_url, notice: 'Deleted customer'
  end

  private
    def find_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit!
    end
end