class Admin::DownloadPaymentsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_payment_pdf }

      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  private
    def payment
      Payment.find(params[:id])
    end

    def download_payment
      DownloadPayment.new(payment)
    end

    def send_payment_pdf
      send_file download_payment.to_pdf, download_attributes
    end

    def render_sample_html
      render download_payment.render_attributes
    end

    def download_attributes
      {
        filename: download_payment.filename,
        type: 'application/pdf',
        disposition: 'inline'
      }
    end
end