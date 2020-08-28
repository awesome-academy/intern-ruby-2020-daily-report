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
                                 order_created: order_type,
                                 show_all: params[:show_all],
                                 per_page: params[:per_page]),
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
                                 order_created: params[:order_created],
                                 show_all: params[:show_all],
                                 per_page: params[:per_page]),
            class: "sort-report-link" do
      tags << content_tag(:span, t(".status"))
      tags << content_tag(:i, "", class: "fas fa-sort-#{icon}")
    end
  end
  # rubocop:enable Metrics/AbcSize

  def link_per_page_manager_reports items_per_page
    link_to items_per_page, manager_reports_path(date: params[:date],
                                 name: params[:name],
                                 email: params[:email],
                                 status: params[:status],
                                 order_status: params[:order_status],
                                 order_created: params[:order_created],
                                 show_all: params[:show_all],
                                 per_page: items_per_page)
  end

  def link_per_page_manager_users items_per_page
    link_to items_per_page, manager_users_path(per_page: items_per_page)
  end

  def link_per_page_reports items_per_page
    link_to items_per_page, reports_path(status: params[:status],
                                         date: params[:date],
                                         per_page: items_per_page)
  end

  # rubocop:disable Metrics/AbcSize
  def link_show_paginate_reports show_all, icon, content
    tags = html_escape("")
    link_to manager_reports_path(date: params[:date],
                                 name: params[:name],
                                 email: params[:email],
                                 status: params[:status],
                                 order_status: params[:order_status],
                                 order_created: params[:order_created],
                                 per_page: params[:per_page],
                                 show_all: show_all),
            class: "report-top-option btn btn-default" do
      tags << content_tag(:i, "", class: "fas fa-#{icon}")
      tags << content_tag(:span, content)
    end
  end
  # rubocop:enable Metrics/AbcSize

  def option_update_status_button value, icon, btn_content
    tags = html_escape("")
    button_tag :submit, class: "btn btn-default report-top-option",
                name: :update_status, value: value do
      tags << content_tag(:i, "", class: "fas fa-#{icon}")
      tags << content_tag(:span, btn_content)
    end
  end
end
