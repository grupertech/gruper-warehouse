class Admin::EventsController < ApplicationController
  respond_to :json, :html
  before_action :set_event, except: [:index, :new, :create]

  def index
    @events = Event.where("start_event <= ? AND end_event >= ?", Date.today, Date.today)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.created_by = current_user.name.present? ? current_user.name : current_user.email

    if @event.save
      redirect_to admin_schedules_url, notice: 'Success created event'
    else
      render 'new', notice: 'Something wrong'
    end
  end

  def edit
  end

  def update
    @event.updated_by = current_user.name.present? ? current_user.name : current_user.email
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :date_range, :start_event, :end_event, :color)
    end
end