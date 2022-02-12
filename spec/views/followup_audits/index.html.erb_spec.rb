require 'rails_helper'

RSpec.describe "followup_audits/index", type: :view do
  before(:each) do
    assign(:followup_audits, [
      FollowupAudit.create!(
        internal_audit: nil,
        notes: "Notes",
        descriptions: "Descriptions",
        file_upload: "File Upload"
      ),
      FollowupAudit.create!(
        internal_audit: nil,
        notes: "Notes",
        descriptions: "Descriptions",
        file_upload: "File Upload"
      )
    ])
  end

  it "renders a list of followup_audits" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Notes".to_s, count: 2
    assert_select "tr>td", text: "Descriptions".to_s, count: 2
    assert_select "tr>td", text: "File Upload".to_s, count: 2
  end
end
