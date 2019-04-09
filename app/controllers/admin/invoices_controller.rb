class Admin::InvoicesController < ApplicationController
  before_action :find_invoice, only: [:show, :edit, :update, :destroy, :update_to_in_process, :update_to_in_shipping, :update_to_cancel, :update_to_completed, :update_to_confirmed, :update_to_paid_partially]

  def index
    @q = Invoice.order('created_at desc').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def pending
    @q = Invoice.order('created_at desc').where(status: 'pending').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def waiting_payment
    @q = Invoice.order('created_at desc').where(status: ['waiting payment', 'paid', 'paid partially', 'paid off (paid partially)']).paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end
  
  def in_process
    @q = Invoice.order('created_at desc').where(status: 'in process').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def in_shipping
    @q = Invoice.order('created_at desc').where(status: 'in shipping').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def completed
    @q = Invoice.order('created_at desc').where(status: 'completed').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def cancel
    @q = Invoice.order('created_at desc').where(status: 'cancel').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def show
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @invoice.save
      redirect_to admin_invoices_url, notice: 'Success added invoice'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @invoice.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @invoice.update(invoice_params)
      redirect_to admin_invoices_url, notice: 'Success updated invoice'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def update_to_waiting_payment
    @invoice.update(status: 'waiting payment')
    redirect_back(fallback_location: admin_invoices_url, notice: 'Invoice In Waiting Payment')
  end

  def update_to_in_process
    @invoice.update(status: 'in process')
    redirect_back(fallback_location: admin_invoices_url, notice: 'Invoice In Proccess')
  end
  
  def update_to_in_shipping
    @invoice.update(status: 'in shipping')
    redirect_back(fallback_location: admin_invoices_url, notice: 'Invoice In Shipping')
  end
  
  def update_to_completed
    @invoice.update(status: 'completed')
    redirect_back(fallback_location: admin_invoices_url, notice: 'Invoice Completed')
  end
  
  def update_to_cancel
    @invoice.update(status: 'cancel')
    redirect_back(fallback_location: admin_invoices_url, notice: 'Invoice Cancel')
  end

  def destroy
    @invoice.destroy
    redirect_to admin_invoices_url, notice: 'Success deleted invoice'
  end

  private
    def find_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:invoice_date, :reference, :customer_id, :vendor_id, :payment_type_id, :order_discount, :shipping, :status, :payment_method, invoice_details_attributes: [:id, :product_id, :tax_id, :cost, :qty, :_destroy])
    end
end