class Admin::Reports::InvoicesController < Admin::Reports::ReportPagesController
  def invoices
    filename = 'All Invoices ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_invoices), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def pending_invoices
    filename = 'Pending Invoices ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_pending_invoices), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def waiting_payment_invoices
    filename = 'Waiting Payment Invoices ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_waiting_payment_invoices), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def in_process_invoices
    filename = 'In Process Invoices ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_in_process_invoices), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def completed_invoices
    filename = 'Completed Invoices ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_completed_invoices), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  def cancel_invoices
    filename = 'Cancel Invoices ' + Date.today.strftime('%y%m%d')
    send_data to_csv(sql_cancel_invoices), type: "text/csv; charset=iso-8859-1; header=present", disposition: "attachment; filename=#{filename}.csv"
  end

  private
    def sql_invoices
      ActiveRecord::Base.connection.execute <<-SQL
        select 
          inv.number_invoice, c.name as customer_name, v.name as vendor_name, inv.status, pt.name as payment_type, inv.subtotal, inv.grand_total
        from invoices inv
        join customers c on c.id = inv.customer_id
        join vendors v on v.id = inv.vendor_id
        join invoice_details invd on inv.id = invd.invoice_id
        join payment_types pt on pt.id = inv.payment_type_id
      SQL
    end

    def sql_pending_invoices
      ActiveRecord::Base.connection.execute <<-SQL
        select 
          inv.number_invoice, c.name as customer_name, v.name as vendor_name, inv.status, pt.name as payment_type, inv.subtotal, inv.grand_total
        from invoices inv
        join customers c on c.id = inv.customer_id
        join vendors v on v.id = inv.vendor_id
        join invoice_details invd on inv.id = invd.invoice_id
        join payment_types pt on pt.id = inv.payment_type_id
        where inv.status in ('pending')
      SQL
    end

    def sql_waiting_payment_invoices
      ActiveRecord::Base.connection.execute <<-SQL
        select 
          inv.number_invoice, c.name as customer_name, v.name as vendor_name, inv.status, pt.name as payment_type, inv.subtotal, inv.grand_total
        from invoices inv
        join customers c on c.id = inv.customer_id
        join vendors v on v.id = inv.vendor_id
        join invoice_details invd on inv.id = invd.invoice_id
        join payment_types pt on pt.id = inv.payment_type_id
        where inv.status in ('paid', 'paid partially', 'paid off (paid partially)')
      SQL
    end

    def sql_in_process_invoices
      ActiveRecord::Base.connection.execute <<-SQL
        select 
          inv.number_invoice, c.name as customer_name, v.name as vendor_name, inv.status, pt.name as payment_type, inv.subtotal, inv.grand_total
        from invoices inv
        join customers c on c.id = inv.customer_id
        join vendors v on v.id = inv.vendor_id
        join invoice_details invd on inv.id = invd.invoice_id
        join payment_types pt on pt.id = inv.payment_type_id
        where inv.status in ('in process')
      SQL
    end

    def sql_completed_invoices
      ActiveRecord::Base.connection.execute <<-SQL
        select 
          inv.number_invoice, c.name as customer_name, v.name as vendor_name, inv.status, pt.name as payment_type, inv.subtotal, inv.grand_total
        from invoices inv
        join customers c on c.id = inv.customer_id
        join vendors v on v.id = inv.vendor_id
        join invoice_details invd on inv.id = invd.invoice_id
        join payment_types pt on pt.id = inv.payment_type_id
        where inv.status in ('completed')
      SQL
    end

    def sql_cancel_invoices
      ActiveRecord::Base.connection.execute <<-SQL
        select 
          inv.number_invoice, c.name as customer_name, v.name as vendor_name, inv.status, pt.name as payment_type, inv.subtotal, inv.grand_total
        from invoices inv
        join customers c on c.id = inv.customer_id
        join vendors v on v.id = inv.vendor_id
        join invoice_details invd on inv.id = invd.invoice_id
        join payment_types pt on pt.id = inv.payment_type_id
        where inv.status in ('cancel')
      SQL
    end
end