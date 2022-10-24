class ViewCount < ApplicationRecord
  def self.increment(path)
    view_count = ViewCount.find_or_create_by(path: path)
    view_count.update_attribute(:views, view_count.views + 1)

    @total = view_count.views
  end

  class << self
    attr_reader :total
  end
end
