# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    alias_action :read, :update, :destroy,:show,:edit, :to => :rud
    alias_action :create,:read, :update,:edit, :destroy,:new,:show, :to => :crud
    alias_action :read, :show, :download, :to => :see
    alias_action :edit, :destroy, :to => :action
      user ||= Permission.new # guest user (not logged in)

    if user.is? 2
      can :manage, :all
    elsif user.is? 4
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      can :manage, Document
      can :manage, DocumentRevision
      can :manage, InternalAudit
      can :manage, Distribution
      can :manage, WrDoc
      can :manage, WrDocDistribution
      can :manage, WrDocRevision
      can :create, LogActivity
      can :see, DakTemplate

    # inputer QM
    elsif user.is? 6
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :view_document, WrDoc
      can :show, WrDoc
      can :edit, WrDoc
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      cannot :soft_delete, WrDoc
      cannot :destroy, WrDoc
      can :manage, Document
      can :manage, DocumentRevision
      can :manage, InternalAudit
      can :manage, Distribution
      can :view_index, WrDoc
      can :view2_index, WrDoc
      can :view3_index, WrDoc
      can :view4_index, WrDoc
      can :home_document, WrDoc
      can :sub_home_document, WrDoc
      can :sub2_home_document, WrDoc
      can :sub3_home_document, WrDoc
      can :sub4_home_document, WrDoc
      can :view_show, WrDoc
      cannot :document_check, Document
      cannot :document_approval, Document
      cannot :document_approval_request, Document
      cannot :document_distribution, Document
      cannot :manage, Distribution
      # cannot :manage, WrDoc
      cannot :manage, WrDocDistribution
      cannot :manage, WrDocRevision
      can :manage, DocumentClassification
      can :manage, DocumentReference
      can :manage, DocumentType
      can :manage, SubDocumentType
      can :manage, Sub2DocumentType
      can :create, LogActivity
      can :index_request, Document
      can :edit_approve, DocumentRequest
      can :index_request, DocumentRequest
      can :sub2_home_qms, Document
      can :see, DakTemplate

    #Inputer Sistem Manajemen
    elsif user.is? 21
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :view_document, WrDoc
      can :show, WrDoc
      can :edit, WrDoc
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      cannot :soft_delete, WrDoc
      cannot :destroy, WrDoc
      can :manage, Document
      can :manage, DocumentRevision
      can :manage, InternalAudit
      can :manage, Distribution
      can :view_index, WrDoc
      can :view2_index, WrDoc
      can :view3_index, WrDoc
      can :view4_index, WrDoc
      can :home_document, WrDoc
      can :sub_home_document, WrDoc
      can :sub2_home_document, WrDoc
      can :sub3_home_document, WrDoc
      can :sub4_home_document, WrDoc
      can :view_show, WrDoc
      cannot :document_check, Document
      cannot :document_approval, Document
      cannot :document_approval_request, Document
      cannot :document_distribution, Document
      cannot :manage, Distribution
      # cannot :manage, WrDoc
      cannot :manage, WrDocDistribution
      cannot :manage, WrDocRevision
      can :manage, DocumentClassification
      can :manage, DocumentReference
      can :manage, DocumentType
      can :manage, SubDocumentType
      can :manage, Sub2DocumentType
      can :create, LogActivity
      can :index_request, Document
      can :edit_approve, DocumentRequest
      can :index_request, DocumentRequest
      can :sub2_home_qms, Document
      can :see, DakTemplate

    # inputer WR
    elsif user.is? 7
      can :crud, Field
      can :crud, Sub2Field
      can :crud, SubField
      can :crud, Sub3Field
      can :crud, Sub4Field
      can :crud, WrDocType
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :hapus, WrDoc
      can :edit, Document
      can :view_all_index, WrDoc
      can :hapus_selamanya, WrDoc
      can :hapus_forever, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :show, Document
      can :download, Document
      can :crud, InternalWrAudit
      can :view_document, WrDoc
      can :view_document, Document
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      cannot :manage, DocumentRevision
      can :manage, InternalAudit
      cannot :manage, Distribution
      cannot :new, Document
      cannot :document_revision, Document
      cannot :document_check, Document
      cannot :document_approval, Document
      cannot :document_approval_request, Document
      cannot :index, Document
      cannot :document_distribution, Document
      cannot :document_distribution, WrDoc
      cannot :manage, WrDocDistribution
      cannot :document_check, WrDoc
      cannot :document_approval, WrDoc
      cannot :soft_delete, Document
      cannot :destroy, Document
      cannot :recycle_bin, Document
      can :recycle_bin, WrDoc
      can :restore, WrDoc
      can :soft_delete, WrDoc
      can :destroy, WrDoc
      can :delete, WrDoc
      can :view_all_index, Document
      can :document_request, Document
      can :document_tracking, Document
      can :view_index, WrDoc
      can :view2_index, WrDoc
      can :view3_index, WrDoc
      can :view4_index, WrDoc
      can :index, WrDoc
      can :home_document, WrDoc
      can :new, WrDoc
      can :crud, WrDoc
      can :view_show, WrDoc
      can :see, WrDocRevision
      can :sub_home_document, WrDoc
      can :sub2_home_document, WrDoc
      can :sub3_home_document, WrDoc
      can :sub4_home_document, WrDoc
      can :report, WrDoc
      can :create, LogActivity
      can :edit_approve, WrDocRequest
      can :sub2_home_qms, Document
      can :view2_base_type, Document
      can :see, DakTemplate

    # inputer Proyek
    elsif user.is? 19
      can :crud, Field
      can :crud, Sub2Field
      can :crud, SubField
      can :crud, Sub3Field
      can :crud, Sub4Field
      can :crud, WrDocType
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :hapus, WrDoc
      can :edit, Document
      can :view_all_index, WrDoc
      can :hapus_selamanya, WrDoc
      can :hapus_forever, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :show, Document
      can :download, Document
      can :crud, InternalWrAudit
      can :view_document, WrDoc
      can :view_document, Document
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      cannot :manage, DocumentRevision
      can :manage, InternalAudit
      cannot :manage, Distribution
      cannot :new, Document
      cannot :document_revision, Document
      cannot :document_check, Document
      cannot :document_approval, Document
      cannot :document_approval_request, Document
      cannot :index, Document
      cannot :document_distribution, Document
      cannot :document_distribution, WrDoc
      cannot :manage, WrDocDistribution
      cannot :document_check, WrDoc
      cannot :document_approval, WrDoc
      cannot :soft_delete, Document
      cannot :destroy, Document
      cannot :recycle_bin, Document
      can :recycle_bin, WrDoc
      can :restore, WrDoc
      can :soft_delete, WrDoc
      can :destroy, WrDoc
      can :delete, WrDoc
      can :view_all_index, Document
      can :document_request, Document
      can :document_tracking, Document
      can :view_index, WrDoc
      can :view2_index, WrDoc
      can :view3_index, WrDoc
      can :view4_index, WrDoc
      can :index, WrDoc
      can :home_document, WrDoc
      can :new, WrDoc
      can :crud, WrDoc
      can :view_show, WrDoc
      can :see, WrDocRevision
      can :sub_home_document, WrDoc
      can :sub2_home_document, WrDoc
      can :sub3_home_document, WrDoc
      can :sub4_home_document, WrDoc
      can :report, WrDoc
      can :create, LogActivity
      can :edit_approve, WrDocRequest
      can :sub2_home_qms, Document
      can :view2_base_type, Document
      can :see, DakTemplate

    # checker QM
    elsif user.is? 8
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :view2_base_type, Document
      can :sub2_home_qms, Document
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      can :manage, Document
      can :manage, DocumentRevision
      can :manage, InternalAudit
      can :manage, Distribution
      can :view_index, WrDoc
      can :home_document, WrDoc
      cannot :manage, WrDocDistribution
      cannot :manage, WrDocRevision
      can :create, LogActivity
      can :see, DakTemplate

    # checker WR
    elsif user.is? 9
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :view2_base_type, Document
      can :sub2_home_qms, Document
      can :view_show, Document

      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      cannot :manage, DocumentRevision
      cannot :manage, InternalAudit
      cannot :manage, Distribution
      can :document_tracking, Document
      can :document_request, Document
      can :view_all_index, Document
      can :manage, WrDoc
      can :manage, WrDocDistribution
      can :manage, WrDocRevision
      can :create, LogActivity
      can :see, DakTemplate

      #staff
    elsif user.is? 10
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      cannot :soft_delete, Document
      cannot :destroy, Document
      cannot :soft_delete, WrDoc
      cannot :destroy, WrDoc
      # can :manage, Document
      can :view_show, Document
      can :index, Document
      can :view_all_index, Document
      can :view_document, Document
      can :home_qms, Document
      can :sub_home_qms, Document
      can :view_base_type, Document
      can :view2_base_type, Document
      can :home, Document

      can :download, DocumentRequest
      can :index_request, DocumentRequest
      can :download, WrDocRequest
      can :sub2_home_qms, Document

      can :download, Document
      can :download, WrDoc
      can :index_request, Document
      can :index_request, WrDoc
      can :request_new, DocumentRequest
      can :new_request, DocumentRequest
      can :request_new, WrDocRequest
      # can :download, Document.joins(:document_request).where('status_request = ? and request_date = ?', 'Approved', Date.current - 3.day).select('*')

      can :show, WrDoc
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :home_document, WrDoc
      can :view_document, WrDoc
      can :sub_home_document, WrDoc
      can :sub2_home_document, WrDoc
      can :sub3_home_document, WrDoc
      can :sub4_home_document, WrDoc
      can :view_index, WrDoc
      can :view2_index, WrDoc
      can :view3_index, WrDoc
      can :view4_index, WrDoc
      can :home, WrDoc
      can :view_show, WrDoc

      # can :manage, WrDoc
      cannot :manage, InternalAudit
      can :manage, Distribution
      can :manage, WrDocDistribution
      can :create, LogActivity
      can :see, DakTemplate

    # Kadiv
    elsif user.is? 12
      can :home, Document
      can :home_qms, Document
      can :index, WrDoc
      can :view_all_index, WrDoc
      can :sub_home_qms, Document
      can :view_base_type, Document
      cannot :manage, Role
      cannot :manage, Permission
      cannot :manage, Member
      can :manage, Document
      can :manage, DocumentRevision
      can :manage, InternalAudit
      can :manage, Distribution
      can :manage, WrDoc
      can :manage, WrDocDistribution
      can :manage, WrDocRevision
      can :create, LogActivity
      can :see, DakTemplate
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
