Rails.application.routes.draw do
  resources :dak_templates
  resources :followup_audits
  resources :followupaudits
  resources :sub4_fields
  resources :sub3_fields
  resources :sub2_fields
  resources :sub2_document_types
  resources :log_activities do
    get :list_login, on: :collection
    get :list_request, on: :collection
    get :report_request, on: :collection
    get :report_all, on: :collection
    get :export_request, on: :collection
    get :report_login, on: :collection
    get :export_login, on: :collection
    get :export_all, on: :collection
  end
  resources :document_classifications
  resources :internal_wr_audits
  resources :wr_doc_requests do
    collection do
      get 'edit_approve/:id' => :edit_approve, as: 'edit_approve'
      get 'download_new_request/:id' => :download_new_request, as: 'download_new_request'
      get 'do_approve_new_request/:id' => :do_approve_new_request, as: 'do_approve_new_request'
      get 'do_reject_new_request/:id' => :do_reject_new_request, as: 'do_reject_new_request'
      get 'edit_reject/:id' => :edit_reject, as: 'edit_reject'
      get 'do_approve_by_superadmin/:id' => :do_approve_by_superadmin, as: 'do_approve_by_superadmin'
      get 'download_hard_copy/:id' => :download_hard_copy, as: 'download_hard_copy'
    end
    get :new_request, on: :collection
    get :index_request, on: :collection
  end
  resources :document_requests do
    collection do
      get 'edit_approve/:id' => :edit_approve, as: 'edit_approve'
      get 'edit_reject/:id' => :edit_reject, as: 'edit_reject'
      get 'download_new_request/:id' => :download_new_request, as: 'download_new_request'
      get 'do_reject_new_request/:id' => :do_reject_new_request, as: 'do_reject_new_request'
      get 'do_approve_new_request/:id' => :do_approve_new_request, as: 'do_approve_new_request'
      get 'do_approve_by_superadmin/:id' => :do_approve_by_superadmin, as: 'do_approve_by_superadmin'
      get 'download_hard_copy/:id' => :download_hard_copy, as: 'download_hard_copy'
    end
    get :new_request, on: :collection
    get :index_request, on: :collection
  end
  resources :document_references
  resources :document_types
  resources :sub_document_types
  resources :wr_doc_types
  resources :report_distributions
  resources :reports
  resources :wr_doc_distributions do
    collection do
      get 'new_distribution/:id' => :new_distribution, as: 'new_distribution'
      get 'download_document/:id' => :download_document, as: 'download_document'
    end
  end
  resources :wr_doc_revisions
  resources :wr_docs do
    get :document_distribution, on: :collection
    get :document_approval, on: :collection
    get :document_approve_request, on: :collection
    get :document_check, on: :collection
    get :home_document, on: :collection
    get :sub_home_document, on: :collection
    get :document_request, on: :collection
    get :view_all_index, on: :collection
    get :index_request, on: :collection
    get :report, on: :collection
    get :recycle_bin, on: :collection
    get :hapus_selamanya, on: :collection
    get :hapus_forever, on: :collection
    # post :index, on: :collection
  end
  resources :wr_docs do
    collection do
      get 'view4_index/:sub4_field_id' => :view4_index, as: 'view4_index'
      get 'view3_index/:sub3_field_id' => :view3_index, as: 'view3_index'
      get 'view2_index/:sub2_field_id' => :view2_index, as: 'view2_index'
      get 'sub4_home_document/:sub3_field_id' => :sub4_home_document, as: 'sub4_home_document'
      get 'sub3_home_document/:sub2_field_id' => :sub3_home_document, as: 'sub3_home_document'
      get 'sub2_home_document/:sub_field_id' => :sub2_home_document, as: 'sub2_home_document'
      get 'soft_delete/:wr_doc_id' => :soft_delete, as: 'soft_delete'
      get 'restore/:wr_doc_id' => :restore, as: 'restore'
      get 'hapus/:wr_doc_id' => :hapus, as: 'hapus'
      get 'view_show/:wr_doc_id' => :view_show, as: 'view_show'
    end
  end
  resources :sub_fields
  resources :distributions do
    collection do
      get 'new_distribution/:id' => :new_distribution, as: 'new_distribution'
      get 'download_document/:id' => :download_document, as: 'download_document'
    end
  end
  resources :internal_audits do
    get :dashboard, on: :collection
  end
  get 'errors/error_404'
  resources :document_revisions
  resources :documents do
    get :view_index, on: :collection
    get :document_approval, on: :collection
    get :document_approve_request, on: :collection
    get :document_check, on: :collection
    get :view_all_index, on: :collection
    get :index_request, on: :collection
    get :document_tracking, on: :collection
    get :document_distribution, on: :collection
    get :document_request, on: :collection
    get :home_qms, on: :collection
    get :home, on: :collection
    get :hapus_forever, on: :collection
    get :report, on: :collection
    get :recycle_bin, on: :collection
    # post :view_all_index, on: :collection
  end
  resources :documents do
    collection do
      get 'report_dak/:document_type_id' => :report_dak, as: 'report_dak'
      get 'report_corporate/:document_type_id' => :report_corporate, as: 'report_corporate'
      get 'sub2_home_qms/:sub_document_type_id' => :sub2_home_qms, as: 'sub2_home_qms'
      get 'view2_base_type/:sub2_document_type_id' => :view2_base_type, as: 'view2_base_type'
      get 'soft_delete/:document_id' => :soft_delete, as: 'soft_delete'
      get 'restore/:document_id' => :restore, as: 'restore'
      get 'hapus/:document_id' => :hapus, as: 'hapus'
      get 'view_show/:document_id' => :view_show, as: 'view_show'
    end
  end
  resources :fields
  resources :permissions
  resources :roles
  controller :sessions do
    get 'switch_role' => :switch_role
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  devise_for :users, controllers: {sessions: "sessions"}
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :members do
    get :ldap, on: :collection
    get :new_ldap, on: :collection
    get :export_user, on: :collection
  end
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'dashboard#analytics'
  root 'documents#home'
  get 'dashboards/dashboard-social',
      to: 'dashboard#social',
      as: :dashboard_social

  # Smartadmin intel
  get 'smartadmin_intel/app_layouts',
      to: 'smartadmin_intel#app_layouts',
      as: :smartadmin_intel_app_layouts
  get 'smartadmin_intel/app_settings',
      to: 'smartadmin_intel#app_settings',
      as: :smartadmin_intel_app_settings
  get 'smartadmin_intel/prebuilt_skins',
      to: 'smartadmin_intel#prebuilt_skins',
      as: :smartadmin_intel_prebuilt_skins
  get 'outlook/inbox', to: 'outlook#inbox', as: :outlook_inbox

  # AJAX
  get 'ajax/email_compose', to: 'ajax#email_compose', as: :ajax_email_compose
  get 'ajax/email_list', to: 'ajax#email_list', as: :ajax_email_list
  get 'ajax/email_opened', to: 'ajax#email_opened', as: :ajax_email_opened
  get 'ajax/email_reply', to: 'ajax#email_reply', as: :ajax_email_reply
  get 'ajax/demo_widget', to: 'ajax#demo_widget', as: :ajax_demo_widget
  get 'ajax/data_list.json', to: 'ajax#data_list', as: :ajax_data_list
  get 'ajax/notify_mail', to: 'ajax#notify_mail', as: :ajax_notify_mail
  get 'ajax/notify_notifications',
      to: 'ajax#notify_notifications',
      as: :ajax_notify_notifications
  get 'ajax/notify_tasks', to: 'ajax#notify_tasks', as: :ajax_notify_tasks

  # Graphs
  get 'graphs/flot_chart', to: 'graphs#flot_chart', as: :graphs_flot_chart
  get 'graphs/morris_charts',
      to: 'graphs#morris_charts',
      as: :graphs_morris_charts
  get 'graphs/sparklines', to: 'graphs#sparklines', as: :graphs_sparklines
  get 'graphs/easy_pie_charts',
      to: 'graphs#easy_pie_charts',
      as: :graphs_easy_pie_charts
  get 'graphs/dygraphs', to: 'graphs#dygraphs', as: :graphs_dygraphs
  get 'graphs/chart_js', to: 'graphs#chart_js', as: :graphs_chart_js
  get 'graphs/highchart_table',
      to: 'graphs#highchart_table',
      as: :graphs_highchart_table

  # Tables
  get 'tables/normal_tables',
      to: 'tables#normal_tables',
      as: :tables_normal_tables
  get 'tables/data_tables', to: 'tables#data_tables', as: :tables_data_tables
  get 'tables/jquery_grid', to: 'tables#jquery_grid', as: :tables_jquery_grid

  # Forms
  get 'forms/smart_form_elements',
      to: 'forms#smart_form_elements',
      as: :forms_smart_form_elements
  get 'forms/smart_form_layouts',
      to: 'forms#smart_form_layouts',
      as: :forms_smart_form_layouts
  get 'forms/smart_form_validations',
      to: 'forms#smart_form_validations',
      as: :forms_smart_form_validations
  get 'forms/bootstrap_form_elements',
      to: 'forms#bootstrap_form_elements',
      as: :forms_bootstrap_form_elements
  get 'forms/bootstrap_form_validation',
      to: 'forms#bootstrap_form_validation',
      as: :forms_bootstrap_form_validation
  get 'forms/form_plugins', to: 'forms#form_plugins', as: :forms_form_plugins
  get 'forms/wizards', to: 'forms#wizards', as: :forms_wizards
  get 'forms/bootstrap_editors',
      to: 'forms#bootstrap_editors',
      as: :forms_bootstrap_editors
  get 'forms/dropzone', to: 'forms#dropzone', as: :forms_dropzone
  get 'forms/image_cropping',
      to: 'forms#image_cropping',
      as: :forms_image_cropping
  get 'forms/ck_editor', to: 'forms#ck_editor', as: :forms_ck_editor

  # UI Elements
  get 'ui_elements/general_elements',
      to: 'ui_elements#general_elements',
      as: :ui_elements_general_elements
  get 'ui_elements/buttons', to: 'ui_elements#buttons', as: :ui_elements_buttons
  get 'ui_elements/icons/font_awesome',
      to: 'ui_elements#icons_font_awesome',
      as: :ui_elements_icons_font_awesome
  get 'ui_elements/icons/glyph_icons',
      to: 'ui_elements#icons_glyph_icons',
      as: :ui_elements_icons_glyph_icons
  get 'ui_elements/icons/flags',
      to: 'ui_elements#icons_flags',
      as: :ui_elements_icons_flags
  get 'ui_elements/grid', to: 'ui_elements#grid', as: :ui_elements_grid
  get 'ui_elements/tree_view',
      to: 'ui_elements#tree_view',
      as: :ui_elements_tree_view
  get 'ui_elements/nestable_lists',
      to: 'ui_elements#nestable_lists',
      as: :ui_elements_nestable_lists
  get 'ui_elements/jquery_ui',
      to: 'ui_elements#jquery_ui',
      as: :ui_elements_jquery_ui
  get 'ui_elements/typography',
      to: 'ui_elements#typography',
      as: :ui_elements_typography

  # Widgets
  get 'widgets/', to: 'widgets#index', as: :widgets

  # Cool Features
  get 'cool_features/calendar',
      to: 'cool_features#calendar',
      as: :cool_features_calendar
  get 'cool_features/gmap_skins',
      to: 'cool_features#gmap_skins',
      as: :cool_features_gmap_skins

  # App Views
  get 'app_views/projects', to: 'app_views#projects', as: :app_views_projects
  get 'app_views/blog', to: 'app_views#blog', as: :app_views_blog
  get 'app_views/gallery', to: 'app_views#gallery', as: :app_views_gallery
  get 'app_views/forum_layout_general_view',
      to: 'app_views#forum_layout_general_view',
      as: :app_views_forum_layout_general_view
  get 'app_views/forum_layout_topic_view',
      to: 'app_views#forum_layout_topic_view',
      as: :app_views_forum_layout_topic_view
  get 'app_views/forum_layout_post_view',
      to: 'app_views#forum_layout_post_view',
      as: :app_views_forum_layout_post_view
  get 'app_views/profile', to: 'app_views#profile', as: :app_views_profile
  get 'app_views/timeline', to: 'app_views#timeline', as: :app_views_timeline
  get 'app_views/search_page',
      to: 'app_views#search_page',
      as: :app_views_search_page

  # E-Commerce
  get 'e_commerce/orders', to: 'e_commerce#orders', as: :e_commerce_orders
  get 'e_commerce/products_view',
      to: 'e_commerce#products_view',
      as: :e_commerce_products_view
  get 'e_commerce/products_detail',
      to: 'e_commerce#products_detail',
      as: :e_commerce_products_detail

  # Miscellaneous
  get 'miscellaneous/pricing_tables',
      to: 'miscellaneous#pricing_tables',
      as: :miscellaneous_pricing_tables
  get 'miscellaneous/invoice',
      to: 'miscellaneous#invoice',
      as: :miscellaneous_invoice
  get 'miscellaneous/login',
      to: 'miscellaneous#login',
      as: :miscellaneous_login
  get 'miscellaneous/register',
      to: 'miscellaneous#register',
      as: :miscellaneous_register
  get 'miscellaneous/forgot_password',
      to: 'miscellaneous#forgot_password',
      as: :miscellaneous_forgot_password
  get 'miscellaneous/locked_screen',
      to: 'miscellaneous#locked_screen',
      as: :miscellaneous_locked_screen
  get 'miscellaneous/error_404',
      to: 'miscellaneous#error_404',
      as: :miscellaneous_error_404
  get 'miscellaneous/error_500',
      to: 'miscellaneous#error_500',
      as: :miscellaneous_error_500
  get 'miscellaneous/blank_page',
      to: 'miscellaneous#blank_page',
      as: :miscellaneous_blank_page

  # Smart chat API
  get 'smart_chat_api/',
      to: 'smart_chat_api#index',
      as: :smart_chat_api

  # Misc methods
  get '/home/set_locale', to: 'home#set_locale', as: :home_set_locale

  # CK editor
  mount Ckeditor::Engine => '/ckeditor'

  #PdfjsViewer
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  get '/dak_templates/download/:id', to: 'dak_templates#download', as: :download_template_dak
  get 'followup_audits/new/:internal_audit_id', to: 'followup_audits#new', as: :new_audit_tindaklanjut
  get 'internal_audits/:id', to: 'internal_audits#show', as: :detail_audit
  get 'internal_audits/closing_audit/:id', to: 'internal_audits#closing_audit', as: :closing_audit
  delete 'followup_audits/:id', to: 'followup_audits#destroy', as: :delete_audit_tindaklanjut
  get '/members/edit_ldap/:member_id', to: 'members#edit_ldap', as: :edit_ldap
  get '/wr_docs/view_index/:sub_field_id', to: 'wr_docs#view_index', as: :reference_document
  get '/document/do_approval/:id', to: 'documents#do_approval', as: :approve
  get '/wr_docs/do_approval/:wr_doc_id', to: 'wr_docs#do_approval', as: :approve_wr_docs
  get '/document_revision/new_to_check/:document_id', to: 'document_revisions#new_to_check', as: :new_to_check
  get '/wr_doc_revisions/new_to_check/:wr_doc_id', to: 'wr_doc_revisions#new_to_check', as: :new_to_check_wr_doc
  get '/document_request/download/:id', to: 'document_requests#download', as: :download_file
  get '/wr_doc_requests/download/:id', to: 'wr_doc_requests#download', as: :download_file_wr_docs
  get '/internal_audit/download/:id', to: 'internal_audits#download', as: :download_file_audit
  get '/followup_audits/download/:id', to: 'followup_audits#download', as: :download_audit_tindaklanjut
  get '/distributions/new_document_distribution/:document_id', to: 'distributions#new_document_distribution', as: :document_distribution
  get '/wr_doc_distributions/new_document_distribution/:wr_doc_id', to: 'wr_doc_distributions#new_document_distribution', as: :document_distribution_wr_doc
  get '/report_distributions/new_document_distribution/:report_id', to: 'report_distributions#new_document_distribution', as: :report_document_distribution
  get '/distributions/receive/:id', to: 'distributions#receive', as: :receive
  get '/wr_doc_distributions/receive/:id', to: 'wr_doc_distributions#receive', as: :receive_wr_doc
  get '/documents/view_document/:document_id', to: 'documents#view_document', as: :view_document
  get '/wr_docs/view_document/:wr_doc_id', to: 'wr_docs#view_document', as: :wr_view_document

  get '/documents/sub_home_qms/:document_type_id', to: 'documents#sub_home_qms', as: :sub_type_document
  get '/documents/view_base_type/:sub_document_type_id', to: 'documents#view_base_type', as: :view_base_type
  get '/wr_docs/view_all_index/:field_id', to: 'wr_docs#view_all_index', as: :all_index_wr_docs
  get '/wr_docs/sub_home_document/:field_id', to: 'wr_docs#sub_home_document', as: :sub_wr_doc

  get '/document_requests/request_new/:document_id', to: 'document_requests#request_new', as: :new_request

  get '/wr_doc_requests/request_new/:wr_doc_id', to: 'wr_doc_requests#request_new', as: :new_wr_request

  get '/document_requests/do_approval/:id', to: 'document_requests#do_approval', as: :approval_request

  get '/document_requests/do_reject/:id', to: 'document_requests#do_reject', as: :reject_request

  # get '/wr_doc_requests/new_request/:wr_doc_id', to: 'wr_doc_requests#new_request', as: :wr_new_request

  get '/wr_doc_requests/do_approval/:id', to: 'wr_doc_requests#do_approval', as: :wr_approval_request

  get '/wr_doc_requests/do_reject/:id', to: 'wr_doc_requests#do_reject', as: :wr_reject_request

  get '/document_requests/document_request_download/:id', to: 'document_requests#document_request_download', as: :request_download

  get '/document_requests/:id/request_pdf', to: 'document_requests#request_pdf', as: 'request_pdf'

  namespace 'api' do
    namespace 'v1' do
      resources :members
      resources :fields
      resources :dak
    end
  end

  # get '*path', to: 'errors#error_404', via: :all
  match '*path', via: :all, to: 'errors#error_404', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
  # get '*all' => 'errors#error_404', constraints: -> (req) { !(req.fullpath =~ /^\/rails\/.*/) }
end
