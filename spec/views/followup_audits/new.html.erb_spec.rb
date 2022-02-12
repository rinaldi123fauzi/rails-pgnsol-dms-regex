require 'rails_helper'

RSpec.describe "followup_audits/new", type: :view do
  before(:each) do
    assign(:followup_audit, FollowupAudit.new(
      internal_audit: nil,
      notes: "MyString",
      descriptions: "MyString",
      file_upload: "MyString"
    ))
  end

  it "renders new followup_audit form" do
    render

    assert_select "form[action=?][method=?]", followup_audits_path, "post" do

      assert_select "input[name=?]", "followup_audit[internal_audit_id]"

      assert_select "input[name=?]", "followup_audit[notes]"

      assert_select "input[name=?]", "followup_audit[descriptions]"

      assert_select "input[name=?]", "followup_audit[file_upload]"
    end
  end
end
