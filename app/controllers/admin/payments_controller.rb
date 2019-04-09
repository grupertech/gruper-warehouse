class Admin::PaymentsController < ApplicationController
  include ActionController::MimeResponds
  before_action :find_payment, only: [:show, :edit, :update, :destroy, :update_to_paid_partially, :update_to_confirmed, :update_to_cancel]
  respond_to :html, :js

  def index
    @q = Payment.order('created_at desc').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @payments = @q.result(distinct: true)
  end

  def paid_partially
    @q = Payment.order('created_at desc').where(status: 'paid partially').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @payments = @q.result(distinct: true)
  end

  def confirmed
    @q = Payment.order('created_at desc').where(status: 'confirmed').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @payments = @q.result(distinct: true)
  end

  def cancel
    @q = Payment.order('created_at desc').where(status: 'cancel').paginate(:page => params[:page], :per_page => 15).ransack(params[:q])
    @payments = @q.result(distinct: true)
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to admin_payments_url, notice: 'Success create payment'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def show
  end

  def edit
  end

  def paid_partially_modal
  end

  def update
    if @payment.update(payment_params)
      redirect_to admin_payments_url, notice: 'Success update payment'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @payment.destroy
    redirect_to admin_payments_url, notice: 'Deleted payment'
  end

  def update_to_paid_partially
    if @payment.update(paid_partially_params)
      redirect_to admin_payments_url, notice: 'Payment has been paid'
    else
      redirect_to admin_payments_url, notice: 'Something wrong'
    end
  end

  def update_to_confirmed
    if @payment.update(status: 'confirmed')
      redirect_to admin_payments_url, notice: 'Payment has been paid'
    else
      redirect_to admin_payments_url, notice: 'Something wrong'
    end
  end

  def update_to_cancel
    if @payment.update(status: 'cancel')
      redirect_to admin_payments_url, notice: 'Payment has been cancel'
    else
      redirect_to admin_payments_url, notice: 'Something wrong'
    end
  end

  private
    def find_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit!
    end

    def paid_partially_params
      params.require(:payment).permit(:amount, :status)
    end
end