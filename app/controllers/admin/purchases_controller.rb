class Admin::PurchasesController < ApplicationController
  before_action :find_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @q = Purchase.order('created_at desc').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def pending
    @q = Purchase.order('created_at desc').where(status: 'pending').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def waiting_payment
    @q = Purchase.order('created_at desc').where(status: ['waiting payment', 'paid', 'paid partially', 'paid off (paid partially)']).paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def in_process
    @q = Purchase.order('created_at desc').where(status: 'in process').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def in_shipping
    @q = Purchase.order('created_at desc').where(status: 'in shipping').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def completed
    @q = Purchase.order('created_at desc').where(status: 'completed').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def cancel
    @q = Purchase.order('created_at desc').where(status: 'cancel').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @purchases = @q.result(distinct: true)
  end

  def show
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @purchase.save
      redirect_to admin_purchases_url, notice: 'Success added purchase'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @purchase.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @purchase.update(purchase_params)
      redirect_to admin_purchases_url, notice: 'Success updated purchase'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def update_to_in_process
    @purchase.update(status: 'waiting payment')
    redirect_back(fallback_location: admin_purchases_url, notice: 'Purchase In Proccess')
  end

  def update_to_in_process
    @purchase.update(status: 'in process')
    redirect_back(fallback_location: admin_purchases_url, notice: 'Purchase In Proccess')
  end
  
  def update_to_in_shipping
    @purchase.update(status: 'in shipping')
    redirect_back(fallback_location: admin_purchases_url, notice: 'Purchase In Shipping')
  end
  
  def update_to_completed
    @purchase.update(status: 'completed')
    redirect_back(fallback_location: admin_purchases_url, notice: 'Purchase Completed')
  end
  
  def update_to_cancel
    @purchase.update(status: 'cancel')
    redirect_back(fallback_location: admin_purchases_url, notice: 'Purchase Cancel')
  end

  def destroy
    @purchase.destroy
    redirect_to admin_purchases_url, notice: 'Success deleted purchase'
  end

  private
    def find_purchase
      @purchase = purchase.find(params[:id])
    end

    def purchase_params
      params.require(:purchase).permit(:purchase_date, :reference, :vendor_id, :payment_type_id, :order_discount, :status, :payment_method, purchase_details_attributes: [:id, :product_id, :tax_id, :cost, :qty, :_destroy])
    end
end