require 'rails_helper'

RSpec.describe "followupaudits/show", type: :view do
  before(:each) do
    @followupaudit = assign(:followupaudit, Followupaudit.create!(
      internal_audit: nil,
      notes: "Notes",
      description: "Description",
      file_upload: "File Upload"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/File Upload/)
  end
end
