class Admin::UnitsController < ApplicationController
  before_action :find_unit, except: [:index, :new, :create]

  def index
    @units = Unit.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @unit.save
      redirect_to admin_units_url, notice: 'Success added unit'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @unit.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @unit.update(unit_params)
      redirect_to admin_units_url, notice: 'Success updated unit'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @unit.destroy
    redirect_to admin_units_url, notice: 'Deleted unit'
  end

  private
    def find_unit
      @unit = Unit.find(params[:id])
    end

    def unit_params
      params.require(:unit).permit!
    end
end