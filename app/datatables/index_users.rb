class IndexUsers
    delegate :link_to, :current_user,
             :edit_member_path, :edit_ldap_path, :member_path,
             :current_user, :params, to: :@view
  
    require 'date'
    require 'action_view'
    include ActionView::Helpers::DateHelper
    # constructor
    def initialize(view)
      @view = view
      # @coba = parsing //for get params from outside form
    end
  
    def as_json(options = {})
      {
          sEcho: params[:sEcho].to_i,
          iTotalRecords: Member.count,
          iTotalDisplayRecords: documents.total_entries,
          aaData: data
      }
    end
  
    private
  
    def data
        documents.each_with_index.map do |member, index|
            ldap = Net::LDAP.new :host => '192.168.60.159',
                                :port => 389,
                                :auth => {
                                    :method => :simple,
                                    :username => "cn=manager, dc=pgn-solution, dc=co, dc=id",
                                    :password => "4lh4mdul1ll4h"
                                }
            filter = Net::LDAP::Filter.eq("cn", "#{member.username}")
            treebase = "dc=pgn-solution, dc=co, dc=id"
            ldap.search(:base => treebase, :filter => filter) do |entry|
                @username = entry["sn"].map(&:inspect).join(', ').gsub('"', '')
            end
            if member.username.match(/#{@username}/)
                [
                    (index + 1),
                    (member.username),
                    (member.nama),
                    (member.email),
                    (member.username.match(/#{@username}/) ? "From Email": "Local DMS"),
                    (member.status),
                    link_to('Edit LDAP', edit_ldap_path(member), remote: true),
                    link_to('Delete', member_path(member), method: :delete, data: {confirm: 'Are you sure?'})
                ]
            else
                [
                    (index + 1),
                    (member.username),
                    (member.nama),
                    (member.email),
                    (member.username.match(/#{@username}/) ? "From Email": "Local DMS"),
                    (member.status),
                    link_to('Edit', edit_member_path(member), remote: true),
                    link_to('Delete', member_path(member), method: :delete, data: {confirm: 'Are you sure?'})
                ]
            end
        end
    end
  
    def documents
      @documents ||= fetch_documents
    end
  
    def fetch_documents
      # documents = InternalAudit.left_outer_joins(:followup_audit).select('internal_audits.id AS idinternalaudits, *').order("internal_audits.audit_date DESC")
      documents = Member.order("username DESC")
      documents = documents.paginate(page: page, per_page: per_page)
      if params[:sSearch].present?
        documents = documents.where("username like :search", search: "%#{params[:sSearch]}%")
      end
      documents
    end
  
    def page
      params[:iDisplayStart].to_i / per_page + 1
    end
  
    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end
  
    def sort_column
      columns = %w[username nama email asal status]
      columns[params[:iSortCol_0].to_i]
    end
  
    def sort_direction
      params[:sSortDir_0] = "desc" ? "desc" : "asc" #ternary operator
    end
  end