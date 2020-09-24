module ApplicationHelper
  def report_new_comment report_id
    new_comment = NewComment.find_by user_id: current_user.id,
                                     report_id: report_id
    new_comment ? new_comment.checked : true
  end

  def new_comment_notify
    current_user.new_comments
                .by_checked false
  end

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
  def link_per_page_manager_reports items_per_page
    if params[:q]
      link_to items_per_page, manager_reports_path(
        q: {created_at_eq: params[:q][:created_at_eq],
            user_name_cont: params[:q][:user_name_cont],
            user_email_cont: params[:q][:user_email_cont],
            status_eq: params[:q][:status_eq]},
        show_all: params[:show_all],
        per_page: items_per_page
      )
    else
      link_to items_per_page, manager_reports_path(
        show_all: params[:show_all],
        per_page: items_per_page
      )
    end
  end
  # rubocop:enable Metrics/AbcSize

  def link_per_page_manager_users items_per_page
    link_to items_per_page, manager_users_path(per_page: items_per_page)
  end

  def link_per_page_reports items_per_page
    if params[:q]
      link_to items_per_page, reports_path(
        status_eq: params[:q][:status_eq],
        created_at_eq: params[:q][:created_at_eq],
        per_page: items_per_page
      )
    else
      link_to items_per_page, reports_path(per_page: items_per_page)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def link_show_paginate_reports show_all, icon, content
    tags = html_escape("")
    if params[:q]
      link_to manager_reports_path(
        q: {created_at_eq: params[:q][:created_at_eq],
            user_name_cont: params[:q][:user_name_cont],
            user_email_cont: params[:q][:user_email_cont],
            status_eq: params[:q][:status_eq]},
        per_page: params[:per_page],
        show_all: show_all
      ), class: "report-top-option btn btn-default" do
        tags << content_tag(:i, "", class: "fas fa-#{icon}")
        tags << content_tag(:span, content)
      end
    else
      link_to manager_reports_path(
        per_page: params[:per_page],
        show_all: show_all
      ), class: "report-top-option btn btn-default" do
        tags << content_tag(:i, "", class: "fas fa-#{icon}")
        tags << content_tag(:span, content)
      end
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
