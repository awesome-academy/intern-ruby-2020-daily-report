module ApplicationHelper
  def item_id index, page
    if page
      index + Settings.paginate.index_plus +
        Settings.paginate.items_per_page *
        (page.to_i - Settings.paginate.page_minus)
    else
      index + Settings.paginate.index_plus
    end
  end
end
