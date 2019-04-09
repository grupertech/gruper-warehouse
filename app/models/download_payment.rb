require 'render_anywhere'

class DownloadPayment
  include RenderAnywhere

  def initialize(payment)
    @payment = payment
  end

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_file("tmp/payment.pdf")
  end

  def filename
    "Payment #{payment.invoice.reference}.pdf"
  end

  def render_attributes
    {
      template: "admin/payments/pdf",
      layout: "pdf",
      locals: { payment: payment }
    }
  end

  private
    attr_reader :payment

    def as_html
      render render_attributes
    end
end