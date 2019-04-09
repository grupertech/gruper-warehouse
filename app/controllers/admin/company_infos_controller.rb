class Admin::CompanyInfosController < ApplicationController
  before_action :find_company_info, except: [:index]
  
  def index
    @company_infos = CompanyInfo.all
  end

  def edit
  end

  def update
    if @company_info.update(company_info_params)
      redirect_to admin_company_info_url, notice: 'Success update company info'
    else
      redirect_to admin_company_info_url, notice: 'Something wrong'
    end
  end

  private
    def find_company_info
      @company_info = CompanyInfo.find(params[:id])
    end

    def company_info_params
      params.require(:company_info).permit!
    end
end