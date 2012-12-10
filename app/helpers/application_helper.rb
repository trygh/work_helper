module ApplicationHelper
  def min_show(minutes)
    "%d:%02d" % minutes.divmod(60)
  end
end
