class Admin::PaymentTypesController < ApplicationController
  before_action :find_payment_type, except: [:index, :new, :create]

  def index
    @payment_types = PaymentType.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @payment_type = PaymentType.new
  end

  def create
    @payment_type = PaymentType.new(payment_type_params)
    @payment_type.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @payment_type.save
      redirect_to admin_payment_types_url, notice: 'Success added payment_type'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @payment_type.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @payment_type.update(payment_type_params)
      redirect_to admin_payment_types_url, notice: 'Success updated payment_type'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @payment_type.destroy
    redirect_to admin_payment_types_url, notice: 'Deleted payment_type'
  end

  private
    def find_payment_type
      @payment_type = PaymentType.find(params[:id])
    end

    def payment_type_params
      params.require(:payment_type).permit!
    end
end