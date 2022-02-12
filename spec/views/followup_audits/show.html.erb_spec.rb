require 'rails_helper'

RSpec.describe "followup_audits/show", type: :view do
  before(:each) do
    @followup_audit = assign(:followup_audit, FollowupAudit.create!(
      internal_audit: nil,
      notes: "Notes",
      descriptions: "Descriptions",
      file_upload: "File Upload"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/Descriptions/)
    expect(rendered).to match(/File Upload/)
  end
end
