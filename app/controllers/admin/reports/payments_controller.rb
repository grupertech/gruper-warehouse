class Admin::Reports::PaymentsController < Admin::Reports::ReportPagesController
  def payments
    filename = 'All Payments ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_payments), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def paid_partially_payments
    filename = 'Paid Partially Payments ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_paid_partially_payments), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def confirmed_payments
    filename = 'Confirmed Payments ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_confirmed_payments), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def cancel_payments
    filename = 'Cancel Payments ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_cancel_payments), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  private
    def sql_payments
      ActiveRecord::Base.connection.execute <<-SQL
        select p.number_payment, inv.number_invoice, p.amount as actual_payment, p.note
        from payments p
        join invoices inv on inv.id = p.invoice_id
      SQL
    end

    def sql_pending_payments
      ActiveRecord::Base.connection.execute <<-SQL
        select p.number_payment, inv.number_invoice, p.amount as actual_payment, p.note
        from payments p
        join invoices inv on inv.id = p.invoice_id
        where inv.status in ('paid partially')
      SQL
    end

    def sql_completed_payments
      ActiveRecord::Base.connection.execute <<-SQL
        select p.number_payment, inv.number_invoice, p.amount as actual_payment, p.note
        from payments p
        join invoices inv on inv.id = p.invoice_id
        where inv.status in ('confirmed')
      SQL
    end

    def sql_cancel_payments
      ActiveRecord::Base.connection.execute <<-SQL
        select p.number_payment, inv.number_invoice, p.amount as actual_payment, p.note
        from payments p
        join invoices inv on inv.id = p.invoice_id
        where inv.status in ('cancel')
      SQL
    end
end