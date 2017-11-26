module GraphsHelper
  def monthly_report(transactions)
    # Keeping this here because of the format option and
    # figure out a better way to do this. But works for now.
    transactions.group_by_day_of_month(:date,
                                       range: Date.current.beginning_of_month..
                                               Date.current
                                       ).sum(:amount)
  end

  def payment_method_pie(payment_methods)
    payment_methods.monthly_transactions.sum(:amount)
  end

  def categories_pie(categories)
    categories.monthly_transactions.sum(:amount)
  end
end
