module ApplicationHelper
  def in_cart?(id)
    @cart.select { |_cid, sections| sections.select { |s| s.id == id }.count.positive? }.count.positive?
  end
end
