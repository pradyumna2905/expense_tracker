module GraphsHelper
  def weekly_report(expenses)
    # Keeping this here because of the format option and
    # figure out a better way to do this. But works for now.
    expenses.group_by_day_of_week(:date,
                                  range: 1.week.ago..Date.today,
                                  format: "%a").
                                  sum(:amount)
  end

  def payment_method_pie(payment_methods)
    payment_methods.weekly_expense_report.sum(:amount)
  end
end
