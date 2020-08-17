module ApplicationHelper
  def item_id index, page
    if page
      index + Settings.paginate.items_per_page * (page.to_i - 1)
    else
      index
    end
  end
end
