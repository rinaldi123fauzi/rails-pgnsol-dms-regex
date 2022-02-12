class ListLoginInLogActivities
  delegate :params, :link_to, to: :@view

  # constructor
  def initialize(view)
    @view = view
    # @coba = parsing //for get params from outside form
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: LogActivity.count,
        iTotalDisplayRecords: log_activities.total_entries,
        aaData: data
    }
  end

  private

  def data
    log_activities.each_with_index.map do |log_activity, index|
      [
          (index + 1),
          (log_activity.username),
          (log_activity.activity_date.strftime('%d %b %Y %H:%M:%S')),
          (log_activity.activity),
          (log_activity.browser),
          (log_activity.ip_address)
      # link_to('Show', log_activity),
      # link_to('Show', log_activity),
      # link_to('Show', log_activity)
      ]
    end
  end

  def log_activities
    @log_activities ||= fetch_log_activities
  end

  def fetch_log_activities
    log_activities = LogActivity.joins(:member).where('controller = ? and action = ?', "sessions", "create").select('*').order("#{sort_column} #{sort_direction}, activity_date DESC")
    log_activities = log_activities.paginate(page: page, per_page: per_page)
    if params[:sSearch].present?
      log_activities = log_activities.where("activity like :search or members.username like :search", search: "%#{params[:sSearch]}%")
    end
    log_activities
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[activity_date username activity browser ip_address]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] = "desc" ? "desc" : "asc"
  end
end