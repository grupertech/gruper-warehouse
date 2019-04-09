class Admin::DashboardsController < ApplicationController
  def index
    @invoices_today = Invoice.invoice_today.count
    @invoices_today_amount = Invoice.invoice_today.sum(:grand_total)

    @invoices_this_week = Invoice.invoice_this_week.count
    @invoices_this_week_amount = Invoice.invoice_this_week.sum("grand_total")

    @invoices_this_month = Invoice.invoice_this_month.count
    @invoices_this_month_amount = Invoice.invoice_this_month.sum(:grand_total)

    @invoices_paid = Invoice.invoice_paid.count
    @invoices_paid_amount = Invoice.invoice_paid.sum(:grand_total)

    @invoices_pending = Invoice.invoice_pending.count
    @invoices_pending_amount = Invoice.invoice_pending.sum(:grand_total)

    @invoices_cancel = Invoice.invoice_cancel.count
    @invoices_cancel_amount = Invoice.invoice_cancel.sum(:grand_total)
  end
end