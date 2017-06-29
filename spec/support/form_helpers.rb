module FormHelpers
  def submit_form
    find('input[name="commit"]').click
  end

  def fill_in_this_with_that(this, that)
    fill_in this.to_s, with: that.to_s
  end

  def find_and_fill_in(this, that)
    find(this.to_s).set(that.to_s)
  end

  def select_this_from_that(this, that)
    select(this.to_s, from: that.to_s)
  end
end
