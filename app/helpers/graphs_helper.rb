module GraphsHelper
  def monthly_report(expenses)
    # Keeping this here because of the format option and
    # figure out a better way to do this. But works for now.
    expenses.group_by_day_of_month(:date,
                                   range: Date.current.beginning_of_month..
                                          Date.today
                                  ).sum(:amount)
  end

  def payment_method_pie(payment_methods)
    payment_methods.weekly_expense_report.sum(:amount)
  end

  def categories_pie(categories)
    categories.weekly_expense_report.sum(:amount)
  end
end
