module PortfolioHelper
  def last_time(time)
    t(:time_last, count: ((Time.now - time) / 1.day).round)
  end
end
