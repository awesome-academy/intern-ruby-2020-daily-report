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

  # rubocop:disable Metrics/AbcSize
  def layout_order_report_created order_created
    if order_created.eql? Settings.order.asc
      order_type = Settings.order.desc
      icon = Settings.icon.sort_down
    else
      order_type = Settings.order.asc
      icon = Settings.icon.sort_up
    end
    tags = html_escape("")
    link_to manager_reports_path(page: params[:page],
                                 date: params[:date],
                                 name: params[:name],
                                 email: params[:email],
                                 status: params[:status],
                                 order_status: params[:order_status],
                                 order_created: order_type),
            class: "sort-report-link" do
      tags << content_tag(:span, t(".date_created"))
      tags << content_tag(:i, "", class: "fas fa-sort-#{icon}")
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def layout_order_report_status order_status
    if order_status.eql? Settings.order.desc
      order_type = Settings.order.asc
      icon = Settings.icon.sort_up
    else
      order_type = Settings.order.desc
      icon = Settings.icon.sort_down
    end
    tags = html_escape("")
    link_to manager_reports_path(page: params[:page],
                                 date: params[:date],
                                 name: params[:name],
                                 email: params[:email],
                                 status: params[:status],
                                 order_status: order_type,
                                 order_created: params[:order_created]),
            class: "sort-report-link" do
      tags << content_tag(:span, t(".status"))
      tags << content_tag(:i, "", class: "fas fa-sort-#{icon}")
    end
  end
  # rubocop:enable Metrics/AbcSize
end
