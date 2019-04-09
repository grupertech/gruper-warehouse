class Admin::TaxesController < ApplicationController
  before_action :find_tax, except: [:index, :new, :create]

  def index
    @taxes = Tax.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @tax = Tax.new
  end

  def create
    @tax = Tax.new(tax_params)
    @tax.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @tax.save
      redirect_to admin_taxes_url, notice: 'Success added tax'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @tax.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @tax.update(tax_params)
      redirect_to admin_taxes_url, notice: 'Success updated tax'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @tax.destroy
    redirect_to admin_taxes_url, notice: 'Deleted tax'
  end

  private
    def find_tax
      @tax = Tax.find(params[:id])
    end

    def tax_params
      params.require(:tax).permit!
    end
end