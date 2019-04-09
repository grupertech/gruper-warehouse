class Admin::CategoriesController < ApplicationController
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.order('created_at desc').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @category.save
      redirect_to admin_categories_url, notice: 'Success added category'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @category.updated_by = current_user.name.present? ? current_user.name : current_user.email

    if @category.update(category_params)
      redirect_to admin_categories_url, notice: 'Success updated category'
    else
      render 'edit', notice: 'Something wrong'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: 'Deleted category'
  end

  private
    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit!
    end
end