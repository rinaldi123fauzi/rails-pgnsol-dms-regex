# :nodoc:
module ApplicationHelper
  require 'open-uri'
  def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
      params[:action] == action_name ? "active" : nil
  end

  def login_activity(activity)
    # remote_ip = open('http://ident.me/').read
    LogActivity.create!  member_id: current_user.member_id,
                         activity: activity,
                         controller: controller_name,
                         action: action_name,
                         browser: request.env['HTTP_USER_AGENT'],
                         ip_address: request.env['REMOTE_ADDR'],
                         # ip_address: remote_ip,
                         activity_date: Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end

  def create_user_activity(document_code, activity)
    # remote_ip = open('http://ident.me/').read
    LogActivity.create!  member_id: current_user.member_id,
                         document_code: document_code,
                         activity: activity,
                         controller: controller_name,
                         action: action_name,
                         browser: request.env['HTTP_USER_AGENT'],
                         # ip_address: request.env['REMOTE_ADDR'],
                         ip_address: request.remote_ip,
                         # ip_address: remote_ip,
                         activity_date: Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end

  def activity_request_document(member, document_code, activity)
    # remote_ip = open('http://ident.me/').read
    LogActivity.create!  member_id: member,
                         document_code: document_code,
                         activity: activity,
                         controller: controller_name,
                         action: action_name,
                         browser: request.env['HTTP_USER_AGENT'],
                         # ip_address: request.env['REMOTE_ADDR'],
                         ip_address: request.remote_ip,
                         # ip_address: remote_ip,
                         activity_date: Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end

  def left_menu
    if can? :manage, :all
      left_menu_entries(left_menu_content)
    elsif current_user.role_id == 6
      left_menu_entries(left_menu_content_inputerqm)
    elsif current_user.role_id == 7
      left_menu_entries(left_menu_content_inputerwr)
    elsif current_user.role_id == 8
      left_menu_entries(left_menu_content_checkerqm)
    elsif current_user.role_id == 9
      left_menu_entries(left_menu_content_checkerwr)
    elsif current_user.role_id == 12
      left_menu_entries(left_menu_content_kadiv)
    else
      left_menu_entries(left_menu_content_staf)
    end
  end

  private

  def selected_locale
    locale = FastGettext.locale
    locale_list.detect {|entry| entry[:locale] == locale}
  end

  def locale_list
    [
      {
        flag: 'us',
        locale: 'en',
        name: 'English (US)',
        alt_name: 'United States'
      },
      {
        flag: 'fr',
        locale: 'fr',
        name: 'Français',
        alt_name: 'France'
      },
      {
        flag: 'es',
        locale: 'es',
        name: 'Español',
        alt_name: 'Spanish'
      },
      {
        flag: 'de',
        locale: 'de',
        name: 'Deutsch',
        alt_name: 'German'
      },
      {
        flag: 'jp',
        locale: 'ja',
        name: '日本語',
        alt_name: 'Japan'
      },
      {
        flag: 'cn',
        locale: 'zh',
        name: '中文',
        alt_name: 'China'
      },
      {
        flag: 'it',
        locale: 'it',
        name: 'Italiano',
        alt_name: 'Italy'
      },
      {
        flag: 'pt',
        locale: 'pt',
        name: 'Portugal',
        alt_name: 'Portugal'
      },
      {
        flag: 'ru',
        locale: 'ru',
        name: 'Русский язык',
        alt_name: 'Russia'
      },
      {
        flag: 'kr',
        locale: 'kr',
        name: '한국어',
        alt_name: 'Korea'
      },
    ]
  end

  def left_menu_entries(entries = [])
    output = ''
    entries.each do |entry|
      children_selected = entry[:children] &&
        entry[:children].any? {|child| current_page?(child[:href]) }
      entry_selected =  current_page?(entry[:href])
      li_class =
      case
        when children_selected
          'open'
        when entry_selected
          'active'
      end
      output +=
        content_tag(:li, class: li_class) do
          subentry = ''
          subentry +=
            link_to entry[:href], title: entry[:title], class: entry[:class], target: entry[:target] do
              link_text = ''
              link_text += entry[:content].html_safe
              if entry[:children]
                if children_selected
                  link_text += '<b class="collapse-sign"><em class="fa fa-minus-square-o"></em></b>'
                else
                  link_text += '<b class="collapse-sign"><em class="fa fa-plus-square-o"></em></b>'
                end
              end

              link_text.html_safe
            end
          if entry[:children]
            if children_selected
              ul_style = 'display: block'
            else
              ul_style = ''
            end
            subentry +=
              "<ul style='#{ul_style}'>" +
                left_menu_entries(entry[:children]) +
                "</ul>"
          end

          subentry.html_safe
        end
    end
    output.html_safe
  end

  def left_menu_content
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Control Management User'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('Management User') + "</span>",
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          {
            href: roles_path,
            title: _('Role'),
            content: "<span class='menu-item-parent'>" + _('Roles') + "</span>"
          },
          {
            href: members_path,
            title: _('Member'),
            content: "<span class='menu-item-parent'>" + _('Member') + "</span>"
          },
          {
            href: permissions_path,
            title: _('Permission'),
            content: "<span class='menu-item-parent'>" + _('Permission') + "</span>"
          },
          {
            href: fields_path,
            title: _('Fields'),
            content: "<span class='menu-item-parent'>" + _('Fields') + "</span>"
          },
          {
            href: sub_fields_path,
            title: _('Sub Fields'),
            content: "<span class='menu-item-parent'>" + _('Sub Fields') + "</span>"
          },
        ]
      },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-cube txt-color-blue'></i> <span class='menu-item-parent'>" + _('SmartAdmin Intel') + "</span>",
      #   children: [
      #     {
      #       href: smartadmin_intel_app_layouts_path,
      #       title: _('Dashboard'),
      #       content: "<i class='fa fa-lg fa-fw fa-gear'></i> <span class='menu-item-parent'>" + _('App Layouts') + "</span>"
      #     },
      #     {
      #       href: smartadmin_intel_prebuilt_skins_path,
      #       title: _('Dashboard'),
      #       content: "<i class='fa fa-lg fa-fw fa-picture-o'></i> <span class='menu-item-parent'>" + _('Prebuilt Skins') + "</span>"
      #     },
      #     {
      #       href: smartadmin_intel_app_settings_path,
      #       title: _('Dashboard'),
      #       content: "<i class='fa fa-cube'></i> " + _('App Settings') + ""
      #     },
      #   ]
      # },
      # {
      #   href: outlook_inbox_path,
      #   content: "<i class='fa fa-lg fa-fw fa-inbox'></i> <span class='menu-item-parent'>" + _('Outlook') + "</span> <span class='badge pull-right inbox-badge margin-right-13'>14</span>",
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-bar-chart-o'></i> <span class='menu-item-parent'>" + _('Graphs') + "</span>",
      #   children: [
      #     {
      #       href: graphs_flot_chart_path,
      #       content: _('Flot Chart')
      #     },
      #     {
      #       href: graphs_morris_charts_path,
      #       content: _('Morris Charts')
      #     },
      #     {
      #       href: graphs_sparklines_path,
      #       content: _('Sparklines')
      #     },
      #     {
      #       href: graphs_easy_pie_charts_path,
      #       content: _('EasyPieCharts')
      #     },
      #     {
      #       href: graphs_dygraphs_path,
      #       content: _('Dygraphs')
      #     },
      #     {
      #       href: graphs_chart_js_path,
      #       content: _('Chart.js')
      #     },
      #     {
      #       href: graphs_highchart_table_path,
      #       content: "" + _('HighchartTable') + " <span class='badge pull-right inbox-badge bg-color-yellow'>" + _('new') + "</span>"
      #     },
      #   ]
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-table'></i> <span class='menu-item-parent'>" + _('Tables') + "</span>",
      #   children: [
      #     {
      #       href: tables_normal_tables_path,
      #       content: _('Normal Tables')
      #     },
      #     {
      #       href: tables_data_tables_path,
      #       content: "" + _('Data Tables') + " <span class='badge inbox-badge bg-color-greenLight hidden-mobile'>" + _('responsive') + "</span>"
      #     },
      #     {
      #       href: tables_jquery_grid_path,
      #       content: _('Jquery Grid')
      #     },
      #   ]
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-pencil-square-o'></i> <span class='menu-item-parent'>" + _('Forms') + "</span>",
      #   children: [
      #     {
      #       href: forms_smart_form_elements_path,
      #       content: _('Smart Form Elements')
      #     },
      #     {
      #       href: forms_smart_form_layouts_path,
      #       content: _('Smart Form Layouts')
      #     },
      #     {
      #       href: forms_smart_form_validations_path,
      #       content: _('Smart Form Validation')
      #     },
      #     {
      #       href: forms_bootstrap_form_elements_path,
      #       content: _('Bootstrap Form Elements')
      #     },
      #     {
      #       href: forms_bootstrap_form_validation_path,
      #       content: _('Bootstrap Form Validation')
      #     },
      #     {
      #       href: forms_form_plugins_path,
      #       content: _('Form Plugins')
      #     },
      #     {
      #       href: forms_wizards_path,
      #       content: _('Wizards')
      #     },
      #     {
      #       href: forms_bootstrap_editors_path,
      #       content: _('Bootstrap Editors')
      #     },
      #     {
      #       href: forms_dropzone_path,
      #       content: _('Dropzone')
      #     },
      #     {
      #       href: forms_image_cropping_path,
      #       content: _('Image Cropping')
      #     },
      #     {
      #       href: forms_ck_editor_path,
      #       content: _('CK Editor')
      #     },
      #   ]
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-desktop'></i> <span class='menu-item-parent'>" + _('UI Elements') + "</span>",
      #   children: [
      #     {
      #       href: ui_elements_general_elements_path,
      #       content: _('General Elements')
      #     },
      #     {
      #       href: ui_elements_buttons_path,
      #       content: _('Buttons')
      #     },
      #     {
      #       href: '#',
      #       content: _('Icons'),
      #       children: [
      #         {
      #           href: ui_elements_icons_font_awesome_path,
      #           content: "<i class='fa fa-plane'></i> " + _('Font Awesome') + ""
      #         },
      #         {
      #           href: ui_elements_icons_glyph_icons_path,
      #           content: "<i class='glyphicon glyphicon-plane'></i> " + _('Glyph Icons') + ""
      #         },
      #         {
      #           href: ui_elements_icons_flags_path,
      #           content: "<i class='fa fa-flag'></i> " + _('Flags') + ""
      #         },
      #       ]
      #     },
      #     {
      #       href: ui_elements_grid_path,
      #       content: _('Grid')
      #     },
      #     {
      #       href: ui_elements_tree_view_path,
      #       content: _('Tree View')
      #     },
      #     {
      #       href: ui_elements_nestable_lists_path,
      #       content: _('Nestable Lists')
      #     },
      #     {
      #       href: ui_elements_jquery_ui_path,
      #       content: _('JQuery UI')
      #     },
      #     {
      #       href: ui_elements_typography_path,
      #       content: _('Typography')
      #     },
      #     {
      #       href: '#',
      #       content: _('Six Level Menu'),
      #       children: [
      #         {
      #           href: '#',
      #           content: "<i class='fa fa-fw fa-folder-open'></i> " + _('Item #2') + "",
      #           children: [
      #             {
      #               href: '#',
      #               content: "<i class='fa fa-fw fa-folder-open'></i> " + _('Sub #2.1') + " ",
      #               children: [
      #                 {
      #                   href: '#',
      #                   content: "<i class='fa fa-fw fa-file-text'></i> " + _('Item #2.1.1') + "",
      #                   children: [
      #                     {
      #                       href: '#',
      #                       content: "<i class='fa fa-fw fa-plus'></i> " + _('Expand') + "",
      #                       children: [
      #                         {
      #                           href: '#',
      #                           content: "<i class='fa fa-fw fa-file-text'></i> " + _('File') + ""
      #                         },
      #                       ]
      #                     },
      #                   ]
      #                 },
      #               ]
      #             },
      #           ]
      #         },
      #         {
      #           href: '#',
      #           content: "<i class='fa fa-fw fa-folder-open'></i> " + _('Item #3') + "",
      #           children: [
      #             {
      #               href: '#',
      #               content: "<i class='fa fa-fw fa-folder-open'></i> " + _('3rd Level') + "",
      #               children: [
      #                 {
      #                   href: '#',
      #                   content: "<i class='fa fa-fw fa-file-text'></i> " + _('File') + ""
      #                 },
      #                 {
      #                   href: '#',
      #                   content: "<i class='fa fa-fw fa-file-text'></i> " + _('File') + ""
      #                 },
      #               ]
      #             },
      #           ]
      #         },
      #         {
      #           href: '#',
      #           class: 'inactive',
      #           content: "<i class='fa fa-fw fa-folder-open'></i> " + _('Item #4 (disabled)') + ""
      #         },
      #       ]
      #     },
      #   ]
      # },
      # {
      #   href: widgets_path,
      #   content: "<i class='fa fa-lg fa-fw fa-list-alt'></i> <span class='menu-item-parent'>" + _('Widgets') + "</span>"
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-cloud'><em>3</em></i> <span class='menu-item-parent'>" + _('Cool Features!') + "</span>",
      #   children: [
      #     {
      #       href: cool_features_calendar_path,
      #       content: "<i class='fa fa-lg fa-fw fa-calendar'></i> <span class='menu-item-parent'>" + _('Calendar') + "</span>"
      #     },
      #     {
      #       href: cool_features_gmap_skins_path,
      #       content: "<i class='fa fa-lg fa-fw fa-map-marker'></i> <span class='menu-item-parent'>" + _('GMap Skins') + "</span><span class='badge bg-color-greenLight pull-right inbox-badge'>9</span>"
      #     },
      #   ]
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-puzzle-piece'></i> <span class='menu-item-parent'>" + _('App Views') + "</span>",
      #   children: [
      #     {
      #       href: app_views_projects_path,
      #       content: "<i class='fa fa-file-text-o'></i> " + _('Projects') + ""
      #     },
      #     {
      #       href: app_views_blog_path,
      #       content: "<i class='fa fa-paragraph'></i> " + _('Blog') + ""
      #     },
      #     {
      #       href: app_views_gallery_path,
      #       content: "<i class='fa fa-picture-o'></i> " + _('Gallery') + ""
      #     },
      #     {
      #       href: '#',
      #       content: "<i class='fa fa-comments'></i> " + _('Forum Layout') + "",
      #       children: [
      #         {
      #           href: app_views_forum_layout_general_view_path,
      #           content: _('General View')
      #         },
      #         {
      #           href: app_views_forum_layout_topic_view_path,
      #           content: _('Topic View')
      #         },
      #         {
      #           href: app_views_forum_layout_post_view_path,
      #           content: _('Post View')
      #         },
      #
      #       ]
      #     },
      #     {
      #       href: app_views_profile_path,
      #       content: "<i class='fa fa-group'></i> " + _('Profile') + ""
      #     },
      #     {
      #       href: app_views_timeline_path,
      #       content: "<i class='fa fa-clock-o'></i> " + _('Timeline') + ""
      #     },
      #     {
      #       href: app_views_search_page_path,
      #       content: "<i class='fa fa-search'></i>  " + _('Search Page') + ""
      #     },
      #   ]
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-shopping-cart'></i> <span class='menu-item-parent'>" + _('E-Commerce') + "</span>",
      #   children: [
      #     {
      #       href: e_commerce_orders_path,
      #       content: _('Orders')
      #     },
      #     {
      #       href: e_commerce_products_view_path,
      #       content: _('Products View')
      #     },
      #     {
      #       href: e_commerce_products_detail_path,
      #       content: _('Products Detail')
      #     },
      #   ]
      # },
      # {
      #   href: '#',
      #   content: "<i class='fa fa-lg fa-fw fa-windows'></i> <span class='menu-item-parent'>" + _('Miscellaneous') + "</span>",
      #   children: [
      #     {
      #       href: miscellaneous_pricing_tables_path,
      #       content: _('Pricing Tables')
      #     },
      #     {
      #       href: miscellaneous_invoice_path,
      #       content: _('Invoice')
      #     },
      #     {
      #       href: miscellaneous_login_path,
      #       content: _('Login')
      #     },
      #     {
      #       href: miscellaneous_register_path,
      #       content: _('Register')
      #     },
      #     {
      #       href: miscellaneous_forgot_password_path,
      #       content: _('Forgot Password')
      #     },
      #     {
      #       href: miscellaneous_locked_screen_path,
      #       content: _('Locked Screen')
      #     },
      #     {
      #       href: miscellaneous_error_404_path,
      #       content: _('Error 404')
      #     },
      #     {
      #       href: miscellaneous_error_500_path,
      #       content: _('Error 500')
      #     },
      #     {
      #       href: miscellaneous_blank_page_path,
      #       content: _('Blank Page')
      #     },
      #   ]
      # },
    ]
  end

  def left_menu_content_inputerqm
    @document = Document.where("issued_by = ? and status = ?", current_user.nama, "Pending Revision").select('*')
    if @document.present?
      # @sign = "<span class='badge bg-color-greenLight pull-left inbox-badge'>!</span>"
      @sign = "  <i class='text-warning fa fa-warning flash animated'></i>"
    else
      @sign = ""
    end
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Quality Management System'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('QM System') + "</span>" + @sign,
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Social Wall'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                {
                  href: new_document_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                },
                # {
                #   # href: distributions_url,
                #   href: document_distribution_documents_path,
                #   title: _('Distribution'),
                #   content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                # },
                # {
                #   # href: dashboard_social_path,
                #   href: distributions_url,
                #   title: _('Receipts'),
                #   content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                # },
                {
                  href: new_internal_audit_path,
                  title: _('Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Internal Audit') + "</span>",
                },
                {
                  href: internal_audits_url,
                  title: _('Log Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Log Internal Audit') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('Control Management'),
            content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>" + @sign,
            children: [
                {
                  href: document_revisions_path,
                  title: _('List Document Revision'),
                  content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
                },
                # {
                #   href: document_check_documents_path,
                #   title: _('Document Check'),
                #   content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
                # },
                # {
                #   href: document_approval_documents_path,
                #   title: _('Document Approval'),
                #   content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
                # },
                # {
                #   href: document_approve_request_documents_path,
                #   title: _('Approval of Document Request'),
                #   content: "<span class='menu-item-parent'>" + _('Approval of Document Request') + "</span>",
                # },
                {
                  href: documents_path,
                  title: _('Manage Document'),
                  content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>" + "<span class='badge bg-color-yellow pull-right inbox-badge flash animated'><b style='color:black;font-size:12px'>" + "#{@document.count}" + "</b></span>",
                },
                # {
                #   href: document_distribution_documents_path,
                #   title: _('Document Distribution'),
                #   content: "<span class='menu-item-parent'>" + _('Document Distribution') + "</span>",
                # },
            ]
          },
          {
            href: document_tracking_documents_path,
            title: _('Document Tracking'),
            content: "<span class='menu-item-parent'>" + _('Document Tracking') + "</span>"
          },
          {
            href: document_request_documents_path,
            title: _('Request Document'),
            content: "<span class='menu-item-parent'>" + _('Request Document') + "</span>"
          },
          {
            href: view_all_index_documents_path,
            title: _('Document Viewer'),
            content: "<span class='menu-item-parent'>" + _('Document Viewer') + "</span>"
          },
        ]
      },
      {
        href: '#',
        title: _('Work Reference Document'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('WR Document') + "</span>",
        children: [
          {
            # href: reference_document_path(1),
            href: "#",
            title: _('Oil'),
            content: "<span class='menu-item-parent'>" + _('Oil') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>",
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>",
              },
            ]
          },
          {
            # href: reference_document_path(12),
            href: "#",
            title: _('Gas'),
            content: "<span class='menu-item-parent'>" + _('Gas') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>",
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>",
              },
            ]
          },
          {
            # href: reference_document_path(2),
            href: "#",
            title: _('Power Plant'),
            content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>",
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>",
              },
            ]
          },
          {
            # href: reference_document_path(3),
            href: "#",
            title: _('Renewable Energy'),
            content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>",
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>",
              },
            ]
          },
          {
            # href: reference_document_path(4),
            href: "#",
            title: _('Civil Property'),
            content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>",
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>",
              },
            ]
          },
          {
            # href: reference_document_path(5),
            href: "#",
            title: _('Civil Infrastructure'),
            content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(6),
            href: "#",
            title: _('Water'),
            content: "<span class='menu-item-parent'>" + _('Water') + "</span>",
            children: [
              {
                href: reference_document_path(6),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(7),
            href: "#",
            title: _('QA/QC'),
            content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(8),
            href: "#",
            title: _('HSSE'),
            content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(9),
            href: "#",
            title: _('Telecomunication'),
            content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(10),
            href: "#",
            title: _('Storage Tank'),
            content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(11),
            href: "#",
            title: _('Mini LNG'),
            content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
        ]
      },
    ]
  end

  def left_menu_content_inputerwr
    @wr_doc = WrDoc.where("issued_by = ? and status = ?", current_user.nama, "Pending Revision").select('*')
    if @wr_doc.present?
      # @sign = "<span class='badge bg-color-greenLight pull-left inbox-badge'>!</span>"
      @sign = "<i class='text-warning fa fa-warning flash animated'></i>"
    else
      @sign = ""
    end
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Quality Management System'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('QM System') + "</span>",
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Social Wall'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          # {
          #   href: "#",
          #   title: _('Document Control'),
          #   content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
          #   children: [
          #       {
          #         href: new_document_path,
          #         title: _('New Document'),
          #         content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
          #       },
          #       # {
          #       #   # href: distributions_url,
          #       #   href: document_distribution_documents_path,
          #       #   title: _('Distribution'),
          #       #   content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
          #       # },
          #       # {
          #       #   # href: dashboard_social_path,
          #       #   href: distributions_url,
          #       #   title: _('Receipts'),
          #       #   content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
          #       # },
          #       {
          #         href: new_internal_audit_path,
          #         title: _('Internal Audit'),
          #         content: "<span class='menu-item-parent'>" + _('Internal Audit') + "</span>",
          #       },
          #       {
          #         href: internal_audits_url,
          #         title: _('Log Internal Audit'),
          #         content: "<span class='menu-item-parent'>" + _('Log Internal Audit') + "</span>",
          #       },
          #   ]
          # },
          # {
          #   href: "#",
          #   title: _('Control Management'),
          #   content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>",
          #   children: [
          #       {
          #         href: document_revisions_path,
          #         title: _('List Document Revision'),
          #         content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
          #       },
          #       # {
          #       #   href: document_check_documents_path,
          #       #   title: _('Document Check'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
          #       # },
          #       # {
          #       #   href: document_approval_documents_path,
          #       #   title: _('Document Approval'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
          #       # },
          #       # {
          #       #   href: document_approve_request_documents_path,
          #       #   title: _('Approval of Document Request'),
          #       #   content: "<span class='menu-item-parent'>" + _('Approval of Document Request') + "</span>",
          #       # },
          #       {
          #         href: documents_path,
          #         title: _('Manage Document'),
          #         content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
          #       },
          #       # {
          #       #   href: document_distribution_documents_path,
          #       #   title: _('Document Distribution'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Distribution') + "</span>",
          #       # },
          #   ]
          # },
          {
            href: document_tracking_documents_path,
            title: _('Document Tracking'),
            content: "<span class='menu-item-parent'>" + _('Document Tracking') + "</span>"
          },
          {
            href: document_request_documents_path,
            title: _('Request Document'),
            content: "<span class='menu-item-parent'>" + _('Request Document') + "</span>"
          },
          {
            href: view_all_index_documents_path,
            title: _('Document Viewer'),
            content: "<span class='menu-item-parent'>" + _('Document Viewer') + "</span>"
          },
        ]
      },
      {
        href: '#',
        title: _('Work Reference Document'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('WR Document') + "</span>" + @sign,
        children: [
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                {
                  href: new_wr_doc_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                },
                # {
                #   # href: distributions_url,
                #   href: document_distribution_wr_docs_path,
                #   title: _('Distribution'),
                #   content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                # },
                # {
                #   # href: dashboard_social_path,
                #   href: wr_doc_distributions_url,
                #   title: _('Receipts'),
                #   content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                # },
            ]
          },
          {
            href: "#",
            title: _('Control Management'),
            content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>" + @sign,
            children: [
                {
                  href: wr_doc_revisions_path,
                  title: _('List Document Revision'),
                  content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
                },
                # {
                #   href: document_check_wr_docs_path,
                #   title: _('Document Check'),
                #   content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
                # },
                # {
                #   href: document_approval_wr_docs_path,
                #   title: _('Document Approval'),
                #   content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
                # },
                {
                  href: wr_docs_path,
                  title: _('Manage Document'),
                  content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>" + "<span class='badge bg-color-yellow pull-right inbox-badge flash animated'><b style='color:black; font-size:12;'>" + "#{@wr_doc.count}" + "</b></span>",
                },
              ]
            },
          {
            # href: reference_document_path(1),
            href: "#",
            title: _('Oil'),
            content: "<span class='menu-item-parent'>" + _('Oil') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(12),
            href: "#",
            title: _('Gas'),
            content: "<span class='menu-item-parent'>" + _('Gas') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(2),
            href: "#",
            title: _('Power Plant'),
            content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(3),
            href: "#",
            title: _('Renewable Energy'),
            content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(4),
            href: "#",
            title: _('Civil Property'),
            content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(5),
            href: "#",
            title: _('Civil Infrastructure'),
            content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(6),
            href: "#",
            title: _('Water'),
            content: "<span class='menu-item-parent'>" + _('Water') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(7),
            href: "#",
            title: _('QA/QC'),
            content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(8),
            href: "#",
            title: _('HSSE'),
            content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(9),
            href: "#",
            title: _('Telecomunication'),
            content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(10),
            href: "#",
            title: _('Storage Tank'),
            content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: "#",
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(11),
            href: "#",
            title: _('Mini LNG'),
            content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
        ]
      },
    ]
  end


  def left_menu_content_checkerqm
    @document = Document.where("checker = ? and status = ? or status = ? or status = ?", current_user.nama, "Open", "Revision Done", "Request").select('*')
    if @document.present?
      # @sign = "<span class='badge bg-color-greenLight pull-left inbox-badge'>!</span>"
      @sign = "  <i class='text-warning fa fa-warning flash animated'></i>"
    else
      @sign = ""
    end
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Quality Management System'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('QM System') + "</span>" + @sign,
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Social Wall'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                {
                  href: new_document_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: document_distribution_documents_path,
                  title: _('Distribution'),
                  content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                },
                {
                  # href: dashboard_social_path,
                  href: distributions_url,
                  title: _('Receipts'),
                  content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                },
                {
                  href: new_internal_audit_path,
                  title: _('Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Internal Audit') + "</span>",
                },
                {
                  href: internal_audits_url,
                  title: _('Log Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Log Internal Audit') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('Control Management'),
            content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>" + @sign,
            children: [
                {
                  href: document_revisions_path,
                  title: _('List Document Revision'),
                  content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
                },
                {
                  href: document_check_documents_path,
                  title: _('Document Check'),
                  content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>" + "<span class='badge bg-color-yellow pull-right inbox-badge flash animated'><b style='color:black;font-size:12px;'>" + "#{@document.count}" + "</b></span>",
                },
                # {
                #   href: document_approval_documents_path,
                #   title: _('Document Approval'),
                #   content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
                # },
                # {
                #   href: document_approve_request_documents_path,
                #   title: _('Approval of Document Request'),
                #   content: "<span class='menu-item-parent'>" + _('Approval of Document Request') + "</span>",
                # },
                {
                  href: documents_path,
                  title: _('Manage Document'),
                  content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
                },
                # {
                #   href: document_distribution_documents_path,
                #   title: _('Document Distribution'),
                #   content: "<span class='menu-item-parent'>" + _('Document Distribution') + "</span>",
                # },
            ]
          },
          {
            href: document_tracking_documents_path,
            title: _('Document Tracking'),
            content: "<span class='menu-item-parent'>" + _('Document Tracking') + "</span>"
          },
          {
            href: document_request_documents_path,
            title: _('Request Document'),
            content: "<span class='menu-item-parent'>" + _('Request Document') + "</span>"
          },
          {
            href: view_all_index_documents_path,
            title: _('Document Viewer'),
            content: "<span class='menu-item-parent'>" + _('Document Viewer') + "</span>"
          },
        ]
      },
      {
        href: '#',
        title: _('Work Reference Document'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('WR Document') + "</span>",
        children: [
          # {
          #   href: "#",
          #   title: _('Document Control'),
          #   content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
          #   children: [
          #       {
          #         href: new_wr_doc_path,
          #         title: _('New Document'),
          #         content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
          #       },
          #       # {
          #       #   # href: distributions_url,
          #       #   href: document_distribution_wr_docs_path,
          #       #   title: _('Distribution'),
          #       #   content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
          #       # },
          #       # {
          #       #   # href: dashboard_social_path,
          #       #   href: wr_doc_distributions_url,
          #       #   title: _('Receipts'),
          #       #   content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
          #       # },
          #   ]
          # },
          # {
          #   href: "#",
          #   title: _('Control Management'),
          #   content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>",
          #   children: [
          #       {
          #         href: wr_doc_revisions_path,
          #         title: _('List Document Revision'),
          #         content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
          #       },
          #       # {
          #       #   href: document_check_wr_docs_path,
          #       #   title: _('Document Check'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
          #       # },
          #       # {
          #       #   href: document_approval_wr_docs_path,
          #       #   title: _('Document Approval'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
          #       # },
          #       {
          #         href: wr_docs_path,
          #         title: _('Manage Document'),
          #         content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
          #       },
          #     ]
          #   },
          {
            # href: reference_document_path(1),
            href: "#",
            title: _('Oil'),
            content: "<span class='menu-item-parent'>" + _('Oil') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(12),
            href: "#",
            title: _('Gas'),
            content: "<span class='menu-item-parent'>" + _('Gas') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(2),
            href: "#",
            title: _('Power Plant'),
            content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(3),
            href: "#",
            title: _('Renewable Energy'),
            content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(4),
            href: "#",
            title: _('Civil Property'),
            content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(5),
            href: "#",
            title: _('Civil Infrastructure'),
            content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(6),
            href: "#",
            title: _('Water'),
            content: "<span class='menu-item-parent'>" + _('Water') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(7),
            href: "#",
            title: _('QA/QC'),
            content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(8),
            href: "#",
            title: _('HSSE'),
            content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(9),
            href: "#",
            title: _('Telecomunication'),
            content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(10),
            href: "#",
            title: _('Storage Tank'),
            content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(11),
            href: "#",
            title: _('Mini LNG'),
            content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
        ]
      },
    ]
  end

  def left_menu_content_checkerwr
    @wr_doc = WrDoc.where("checker = ? and status = ? or status = ?", current_user.nama, "Open", "Revision Done").select('*')
    if @wr_doc.present?
      # @sign = "<span class='badge bg-color-greenLight pull-left inbox-badge'>!</span>"
      @sign = "<i class='text-warning fa fa-warning flash animated'></i>"
    else
      @sign = ""
    end
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Quality Management System'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('QM System') + "</span>",
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Social Wall'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          # {
          #   href: "#",
          #   title: _('Document Control'),
          #   content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
          #   children: [
          #       {
          #         href: new_document_path,
          #         title: _('New Document'),
          #         content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
          #       },
          #       {
          #         # href: distributions_url,
          #         href: document_distribution_documents_path,
          #         title: _('Distribution'),
          #         content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
          #       },
          #       {
          #         # href: dashboard_social_path,
          #         href: distributions_url,
          #         title: _('Receipts'),
          #         content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
          #       },
          #       {
          #         href: new_internal_audit_path,
          #         title: _('Internal Audit'),
          #         content: "<span class='menu-item-parent'>" + _('Internal Audit') + "</span>",
          #       },
          #       {
          #         href: internal_audits_url,
          #         title: _('Log Internal Audit'),
          #         content: "<span class='menu-item-parent'>" + _('Log Internal Audit') + "</span>",
          #       },
          #   ]
          # },
          # {
          #   href: "#",
          #   title: _('Control Management'),
          #   content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>",
          #   children: [
          #       {
          #         href: document_revisions_path,
          #         title: _('List Document Revision'),
          #         content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
          #       },
          #       {
          #         href: document_check_documents_path,
          #         title: _('Document Check'),
          #         content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
          #       },
          #       {
          #         href: document_approval_documents_path,
          #         title: _('Document Approval'),
          #         content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
          #       },
          #       {
          #         href: document_approve_request_documents_path,
          #         title: _('Approval of Document Request'),
          #         content: "<span class='menu-item-parent'>" + _('Approval of Document Request') + "</span>",
          #       },
          #       {
          #         href: documents_path,
          #         title: _('Manage Document'),
          #         content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
          #       },
          #       # {
          #       #   href: document_distribution_documents_path,
          #       #   title: _('Document Distribution'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Distribution') + "</span>",
          #       # },
          #   ]
          # },
          {
            href: document_tracking_documents_path,
            title: _('Document Tracking'),
            content: "<span class='menu-item-parent'>" + _('Document Tracking') + "</span>"
          },
          {
            href: document_request_documents_path,
            title: _('Request Document'),
            content: "<span class='menu-item-parent'>" + _('Request Document') + "</span>"
          },
          {
            href: view_all_index_documents_path,
            title: _('Document Viewer'),
            content: "<span class='menu-item-parent'>" + _('Document Viewer') + "</span>"
          },
        ]
      },
      {
        href: '#',
        title: _('Work Reference Document'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('WR Document') + "</span>" + @sign,
        children: [
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                {
                  href: new_wr_doc_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: document_distribution_wr_docs_path,
                  title: _('Distribution'),
                  content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                },
                {
                  # href: dashboard_social_path,
                  href: wr_doc_distributions_url,
                  title: _('Receipts'),
                  content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('Control Management'),
            content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>" + @sign,
            children: [
                {
                  href: wr_doc_revisions_path,
                  title: _('List Document Revision'),
                  content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
                },
                {
                  href: document_check_wr_docs_path,
                  title: _('Document Check'),
                  content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>" + "<span class='badge bg-color-yellow pull-right inbox-badge flash animated'><b style='color:black; font-size:12px;'>" + "#{@wr_doc.count}" + "</b></span>",
                },
                # {
                #   href: document_approval_wr_docs_path,
                #   title: _('Document Approval'),
                #   content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
                # },
                {
                  href: wr_docs_path,
                  title: _('Manage Document'),
                  content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
                },
              ]
            },
          {
            # href: reference_document_path(1),
            href: "#",
            title: _('Oil'),
            content: "<span class='menu-item-parent'>" + _('Oil') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(12),
            href: "#",
            title: _('Gas'),
            content: "<span class='menu-item-parent'>" + _('Gas') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(2),
            href: "#",
            title: _('Power Plant'),
            content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(3),
            href: "#",
            title: _('Renewable Energy'),
            content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(4),
            href: "#",
            title: _('Civil Property'),
            content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(5),
            href: "#",
            title: _('Civil Infrastructure'),
            content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(6),
            href: "#",
            title: _('Water'),
            content: "<span class='menu-item-parent'>" + _('Water') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(7),
            href: "#",
            title: _('QA/QC'),
            content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(8),
            href: "#",
            title: _('HSSE'),
            content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(9),
            href: "#",
            title: _('Telecomunication'),
            content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(10),
            href: "#",
            title: _('Storage Tank'),
            content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(11),
            href: "#",
            title: _('Mini LNG'),
            content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
        ]
      },
    ]
  end

  def left_menu_content_kadiv
    @document = Document.where("approve = ? and status = ?", current_user.nama, "Pending Approval2").where(reason: "").select('*')
    @document_request = Document.where("approve = ? and status = ?", current_user.nama, "Pending Approval2").where.not(reason: "").select('*')
    @wr_doc = WrDoc.where("approve = ? and status = ?", current_user.nama, "Pending Approval2").select('*')
    if @document.present? and @document_request.present? and !@wr_doc.present?
      @sign_document = "<i class='text-warning fa fa-warning flash animated'></i>"
      @sign_wr_doc = ""
    elsif !@document.present? and @document_request.present? and !@wr_doc.present?
      @sign_document = "<i class='text-warning fa fa-warning flash animated'></i>"
      @sign_wr_doc = ""
    elsif @document.present? and !@document_request.present? and !@wr_doc.present?
      @sign_document = "<i class='text-warning fa fa-warning flash animated'></i>"
      @sign_wr_doc = ""
    elsif @wr_doc.present? and !@document.present? and !@document_request.present?
      @sign_document = ""
      @sign_wr_doc = "<i class='text-warning fa fa-warning flash animated'></i>"
    elsif @wr_doc.present? and @document_request.present? and @document.present?
      @sign_wr_doc = "<i class='text-warning fa fa-warning flash animated'></i>"
      @sign_document = "<i class='text-warning fa fa-warning flash animated'></i>"
    elsif @document.present? and @wr_doc.present? and !@document_request.present?
      @sign_wr_doc = "<i class='text-warning fa fa-warning flash animated'></i>"
      @sign_document = "<i class='text-warning fa fa-warning flash animated'></i>"
    elsif @wr_doc.present? and @document_request.present? and !@document.present?
      @sign_wr_doc = "<i class='text-warning fa fa-warning flash animated'></i>"
      @sign_document = "<i class='text-warning fa fa-warning flash animated'></i>"
    else
      @sign_wr_doc = ""
      @sign_document = ""
    end
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Quality Management System'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('QM System') + "</span>" + @sign_document,
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Social Wall'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                {
                  href: new_document_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: document_distribution_documents_path,
                  title: _('Distribution'),
                  content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                },
                {
                  # href: dashboard_social_path,
                  href: distributions_url,
                  title: _('Receipts'),
                  content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                },
                {
                  href: new_internal_audit_path,
                  title: _('Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Internal Audit') + "</span>",
                },
                {
                  href: internal_audits_url,
                  title: _('Log Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Log Internal Audit') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('Control Management'),
            content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>" + @sign_document,
            children: [
                {
                  href: document_revisions_path,
                  title: _('List Document Revision'),
                  content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
                },
                {
                  href: document_check_documents_path,
                  title: _('Document Check'),
                  content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
                },
                {
                  href: document_approval_documents_path,
                  title: _('Document Approval'),
                  content: "<span class='menu-item-parent'>" + "<span class='badge bg-color-yellow pull-left inbox-badge flash animated'><b style='color:black; font-size:12px;'>" + "#{@document.count}" + "</b></span>" + _('Document Approval') + "</span>",
                },
                {
                  href: document_approve_request_documents_path,
                  title: _('Approval of Document Request'),
                  content: "<span class='menu-item-parent'>" "<span class='badge bg-color-yellow pull-left inbox-badge flash animated' style='position:relative;'><b style='color:black; font-size:12px;'>" + "#{@document_request.count}" + "</b></span>" + _('Approval of Document Request') + "</span>",
                },
                {
                  href: documents_path,
                  title: _('Manage Document'),
                  content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
                },
                # {
                #   href: document_distribution_documents_path,
                #   title: _('Document Distribution'),
                #   content: "<span class='menu-item-parent'>" + _('Document Distribution') + "</span>",
                # },
            ]
          },
          {
            href: document_tracking_documents_path,
            title: _('Document Tracking'),
            content: "<span class='menu-item-parent'>" + _('Document Tracking') + "</span>"
          },
          {
            href: document_request_documents_path,
            title: _('Request Document'),
            content: "<span class='menu-item-parent'>" + _('Request Document') + "</span>"
          },
          {
            href: view_all_index_documents_path,
            title: _('Document Viewer'),
            content: "<span class='menu-item-parent'>" + _('Document Viewer') + "</span>"
          },
        ]
      },
      {
        href: '#',
        title: _('Work Reference Document'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('WR Document') + "</span>" + @sign_wr_doc,
        children: [
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                {
                  href: new_wr_doc_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: document_distribution_wr_docs_path,
                  title: _('Distribution'),
                  content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                },
                {
                  # href: dashboard_social_path,
                  href: wr_doc_distributions_url,
                  title: _('Receipts'),
                  content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('Control Management'),
            content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>" + @sign_wr_doc,
            children: [
                {
                  href: wr_doc_revisions_path,
                  title: _('List Document Revision'),
                  content: "<span class='menu-item-parent'>" + _('List Document Revision') + "</span>",
                },
                {
                  href: document_check_wr_docs_path,
                  title: _('Document Check'),
                  content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
                },
                {
                  href: document_approval_wr_docs_path,
                  title: _('Document Approval'),
                  content: "<span class='menu-item-parent'>" + "<span class='badge bg-color-yellow pull-left inbox-badge flash animated'><b style='color:black; font-size:12px;'>" + "#{@wr_doc.count}" + "</b></span>" + _('Document Approval') + "</span>",
                },
                {
                  href: wr_docs_path,
                  title: _('Manage Document'),
                  content: "<span class='menu-item-parent'>" + _('Manage Document') + "</span>",
                },
              ]
            },
          {
            # href: reference_document_path(1),
            href: "#",
            title: _('Oil'),
            content: "<span class='menu-item-parent'>" + _('Oil') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(12),
            href: "#",
            title: _('Gas'),
            content: "<span class='menu-item-parent'>" + _('Gas') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(2),
            href: "#",
            title: _('Power Plant'),
            content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(3),
            href: "#",
            title: _('Renewable Energy'),
            content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(4),
            href: "#",
            title: _('Civil Property'),
            content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(5),
            href: "#",
            title: _('Civil Infrastructure'),
            content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(6),
            href: "#",
            title: _('Water'),
            content: "<span class='menu-item-parent'>" + _('Water') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(7),
            href: "#",
            title: _('QA/QC'),
            content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(8),
            href: "#",
            title: _('HSSE'),
            content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(9),
            href: "#",
            title: _('Telecomunication'),
            content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(10),
            href: "#",
            title: _('Storage Tank'),
            content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(11),
            href: "#",
            title: _('Mini LNG'),
            content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
        ]
      },
      {
        href: '#',
        title: _('Project Quality Audit EPC'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('PQ Audit EPC') + "</span>",
        children: [
          {
            href: "#",
            title: _('Audit Report'),
            content: "<span class='menu-item-parent'>" + _('Audit Report') + "</span>",
            children: [
                {
                  href: report_distributions_url,
                  title: _('List Distribution'),
                  content: "<span class='menu-item-parent'>" + _('List Distribution') + "</span>",
                },
                {
                  href: new_report_path,
                  title: _('New Document'),
                  content: "<span class='menu-item-parent'>" + _('New Report') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: reports_url,
                  title: _('Log'),
                  content: "<span class='menu-item-parent'>" + _('Log') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('Finding'),
            content: "<span class='menu-item-parent'>" + _('Finding') + "</span>",
            children: [
                {
                  href: new_finding_path,
                  title: _('Input Finding'),
                  content: "<span class='menu-item-parent'>" + _('Input Finding') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: findings_url,
                  title: _('Log Finding'),
                  content: "<span class='menu-item-parent'>" + _('Log Finding') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('NCR'),
            content: "<span class='menu-item-parent'>" + _('NCR') + "</span>",
            children: [
                {
                  href: new_ncr_path,
                  title: _('Input NCR'),
                  content: "<span class='menu-item-parent'>" + _('Input NCR') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: ncrs_url,
                  title: _('Log NCR'),
                  content: "<span class='menu-item-parent'>" + _('Log NCR') + "</span>",
                },
            ]
          },
          {
            href: "#",
            title: _('CPAR'),
            content: "<span class='menu-item-parent'>" + _('CPAR') + "</span>",
            children: [
                {
                  href: new_cpar_path,
                  title: _('Input CPAR'),
                  content: "<span class='menu-item-parent'>" + _('Input CPAR') + "</span>",
                },
                {
                  # href: distributions_url,
                  href: cpars_url,
                  title: _('Log CPAR'),
                  content: "<span class='menu-item-parent'>" + _('Log CPAR') + "</span>",
                },
            ]
          },
        ]
      }
    ]
  end

  def left_menu_content_staf
    @documents = Distribution.joins(:document).where('distributions.receiver = ? and distributions.status = ?', current_user.nama, "Pending").select('*')
    if @documents.present?
      @sign = "<i class='text-warning fa fa-warning flash animated'></i>"
    else
      @sign = ""
    end
    [
      {
        href: root_path,
        title: _('Home'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i><span class='menu-item-parent'>" + _('Home') + "</span>",
      },
      {
        href: '#',
        title: _('Quality Management System'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('QM System') + "</span>" + @sign,
        children: [
          # {
          #   href: root_path,
          #   title: _('Dashboard'),
          #   content: "<span class='menu-item-parent'>" + _('Analytics Dashboard') + "</span>"
          # },
          # {
          #   href: dashboard_social_path,
          #   title: _('Social Wall'),
          #   content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          # },
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>" + @sign,
            children: [
                # {
                #   href: documents_path,
                #   title: _('New Document'),
                #   content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                # },
                {
                  # href: dashboard_social_path,
                  href: distributions_url,
                  title: _('Receipts'),
                  content: "<span class='menu-item-parent'>" + "<span class='badge bg-color-yellow pull-left inbox-badge flash animated'><b style='color:black; font-size:12px;'>" + "#{@documents.count}" + "</b></span>" + _('Receipts') + "</span>",
                },
                {
                  href: internal_audits_url,
                  title: _('Log Internal Audit'),
                  content: "<span class='menu-item-parent'>" + _('Log Internal Audit') + "</span>",
                },
            ]
          },
          # {
          #   href: "#",
          #   title: _('Control Management'),
          #   content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>",
          #   children: [
          #       {
          #         href: document_check_documents_path,
          #         title: _('Document Check'),
          #         content: "<span class='menu-item-parent'>" + _('Document Check') + "</span>",
          #       },
          #       {
          #         href: document_approval_documents_path,
          #         title: _('Document Approval'),
          #         content: "<span class='menu-item-parent'>" + _('Document Approval') + "</span>",
          #       },
          #       {
          #         href: document_approve_request_documents_path,
          #         title: _('Approval of Document Request'),
          #         content: "<span class='menu-item-parent'>" + _('Approval of Document Request') + "</span>",
          #       },
          #       # {
          #       #   href: document_distribution_documents_path,
          #       #   title: _('Document Distribution'),
          #       #   content: "<span class='menu-item-parent'>" + _('Document Distribution') + "</span>",
          #       # },
          #   ]
          # },
          # {
          #   href: document_tracking_documents_path,
          #   title: _('Document Tracking'),
          #   content: "<span class='menu-item-parent'>" + _('Document Tracking') + "</span>"
          # },
          {
            href: document_request_documents_path,
            title: _('Request Document'),
            content: "<span class='menu-item-parent'>" + _('Request Document') + "</span>"
          },
          {
            href: view_all_index_documents_path,
            title: _('Document Viewer'),
            content: "<span class='menu-item-parent'>" + _('Document Viewer') + "</span>"
          },
        ]
      },
      {
        href: '#',
        title: _('Work Reference Document'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('WR Document') + "</span>",
        children: [
          {
            href: "#",
            title: _('Document Control'),
            content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>",
            children: [
                # {
                #   href: new_wr_doc_path,
                #   title: _('New Document'),
                #   content: "<span class='menu-item-parent'>" + _('New Document') + "</span>",
                # },
                # {
                #   # href: distributions_url,
                #   href: document_distribution_wr_docs_path,
                #   title: _('Distribution'),
                #   content: "<span class='menu-item-parent'>" + _('Distribution') + "</span>",
                # },
                {
                  # href: dashboard_social_path,
                  href: wr_doc_distributions_url,
                  title: _('Receipts'),
                  content: "<span class='menu-item-parent'>" + _('Receipts') + "</span>",
                },
            ]
          },
          # {
          #   href: reference_document_path(1),
          #   title: _('Oil'),
          #   content: "<span class='menu-item-parent'>" + _('Oil') + "</span>"
          # },
          # {
          #   href: reference_document_path(12),
          #   title: _('Gas'),
          #   content: "<span class='menu-item-parent'>" + _('Gas') + "</span>"
          # },
          # {
          #   href: reference_document_path(2),
          #   title: _('Power Plant'),
          #   content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>"
          # },
          # {
          #   href: reference_document_path(3),
          #   title: _('Renewable Energy'),
          #   content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>"
          # },
          # {
          #   href: reference_document_path(4),
          #   title: _('Civil Property'),
          #   content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>"
          # },
          # {
          #   href: reference_document_path(5),
          #   title: _('Civil Infrastructure'),
          #   content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>"
          # },
          # {
          #   href: reference_document_path(6),
          #   title: _('Water'),
          #   content: "<span class='menu-item-parent'>" + _('Water') + "</span>"
          # },
          # {
          #   href: reference_document_path(7),
          #   title: _('QA/QC'),
          #   content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>"
          # },
          # {
          #   href: reference_document_path(8),
          #   title: _('HSSE'),
          #   content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>"
          # },
          # {
          #   href: reference_document_path(9),
          #   title: _('Telecomunication'),
          #   content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>"
          # },
          # {
          #   href: reference_document_path(10),
          #   title: _('Storage Tank'),
          #   content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>"
          # },
          # {
          #   href: reference_document_path(11),
          #   title: _('Mini LNG'),
          #   content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>"
          # },
          {
            # href: reference_document_path(1),
            href: "#",
            title: _('Oil'),
            content: "<span class='menu-item-parent'>" + _('Oil') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(12),
            href: "#",
            title: _('Gas'),
            content: "<span class='menu-item-parent'>" + _('Gas') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(2),
            href: "#",
            title: _('Power Plant'),
            content: "<span class='menu-item-parent'>" + _('Power Plant') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(3),
            href: "#",
            title: _('Renewable Energy'),
            content: "<span class='menu-item-parent'>" + _('Renewable Energy') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(4),
            href: "#",
            title: _('Civil Property'),
            content: "<span class='menu-item-parent'>" + _('Civil Property') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(5),
            href: "#",
            title: _('Civil Infrastructure'),
            content: "<span class='menu-item-parent'>" + _('Civil Infrastructure') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(6),
            href: "#",
            title: _('Water'),
            content: "<span class='menu-item-parent'>" + _('Water') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(7),
            href: "#",
            title: _('QA/QC'),
            content: "<span class='menu-item-parent'>" + _('QA/QC') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(8),
            href: "#",
            title: _('HSSE'),
            content: "<span class='menu-item-parent'>" + _('HSSE') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(9),
            href: "#",
            title: _('Telecomunication'),
            content: "<span class='menu-item-parent'>" + _('Telecomunication') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(10),
            href: "#",
            title: _('Storage Tank'),
            content: "<span class='menu-item-parent'>" + _('Storage Tank') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          {
            # href: reference_document_path(11),
            href: "#",
            title: _('Mini LNG'),
            content: "<span class='menu-item-parent'>" + _('Mini LNG') + "</span>",
            children: [
              {
                href: reference_document_path(1),
                title: _('Contoh 1'),
                content: "<span class='menu-item-parent'>" + _('Contoh 1') + "</span>"
              },
              {
                href: reference_document_path(1),
                title: _('Contoh 2'),
                content: "<span class='menu-item-parent'>" + _('Contoh 2') + "</span>"
              },
            ]
          },
          # {
          #   href: "#",
          #   title: _('Document Control'),
          #   content: "<span class='menu-item-parent'>" + _('Document Control') + "</span>"
          # },
          # {
          #   href: "#",
          #   title: _('Control Management'),
          #   content: "<span class='menu-item-parent'>" + _('Control Management') + "</span>"
          # },
        ]
      },
    ]
  end
end
