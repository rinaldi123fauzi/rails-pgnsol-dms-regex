class MembersController < ApplicationController
  before_action :logged_in_user
  #before_action :token_exist?
  protect_from_forgery :except => [:update, :destroy, :create]
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :json
  # GET /members
  # GET /members.json

  def export_user
    @log_request = Permission.left_outer_joins(:member,:role).where("permissions.role_id in (?)", [2,6,7]).select('members.nama AS namamembers, members.username, members.email, roles.nama_role, members.status').order('members.nama ASC, roles.nama_role DESC')
    # end
    respond_to do |format|
      format.html { head :no_content }
      format.pdf do
        # render :orientation => 'Landscape',:encoding => "utf8", :layout => "pdf_layout", pdf: "assessment_pdf.pdf"
        render :orientation => 'Landscape', :encoding => "utf8", :layout => "pdf_layout", pdf: "reportLogin_" + Time.now.strftime('%Y%m%d%H%I%S'), :footer => {:right => '[page] of [topage]', :font_size => 8}, margin: {bottom: 4,
                                                                                                                                                                                                                          left: 2,
                                                                                                                                                                                                                          right: 2}
        # render :orientation => 'Portrait',:encoding => "utf8", :layout => "pdf_layout", pdf: "reportQMS_" + Time.now.strftime('%Y%m%d%H%I%S') + ".pdf"
      end
    end
  end

  def new_ldap
    @member = Member.new
  end

  def edit_ldap
    @member = Member.find_by(member_id: params[:member_id])
  end

  def ldap
    #code
  end

  def index
    respond_to do |format|
      format.html
      # you can pass the view_context if you want to use helper methods\
      # @coba = "rinaldi.fauzi"
      # for parsing params from outside
      # format.json {render json: LogActivitiesDatatable.new(view_context, {coba: @coba})}
      #------------END---------------------
      format.json { render json: IndexUsers.new(view_context) }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        login_activity current_user.nama + " has been created user with name " + params[:member][:nama]
        format.html { redirect_to members_url, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        # format.html { render :new }
        format.html { render :new_ldap }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        # format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.html { redirect_to members_url, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
        format.js { render inline: "location.reload();" }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.js { render inline: "location.reload();" }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:username, :password, :password_confirmation, :nama, :email, :last_login, :status)
  end
end
