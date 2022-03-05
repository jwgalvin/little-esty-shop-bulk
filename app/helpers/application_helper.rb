module ApplicationHelper

  def date_format(date)
    date.strftime("%A, %B %d, %Y")
  end

  def penny_to_dollar(pennies)
    dollar = (pennies.to_f/100).round(2)
  end

  def invoice_mather(invoice)
    total = penny_to_dollar(invoice.total_revenue - invoice.dis_counter)
  end
end
