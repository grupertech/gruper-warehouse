class Admin::DownloadsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_invoice_pdf }

      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  private
    def invoice
      Invoice.find(params[:id])
    end

    def download_invoice
      Download.new(invoice)
    end

    def send_invoice_pdf
      send_file download_invoice.to_pdf, download_attributes
    end

    def render_sample_html
      render download_invoice.render_attributes
    end

    def download_attributes
      {
        filename: download_invoice.filename,
        type: 'application/pdf',
        disposition: 'inline'
      }
    end
end