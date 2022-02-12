require 'rails_helper'

RSpec.describe "followupaudits/index", type: :view do
  before(:each) do
    assign(:followupaudits, [
      Followupaudit.create!(
        internal_audit: nil,
        notes: "Notes",
        description: "Description",
        file_upload: "File Upload"
      ),
      Followupaudit.create!(
        internal_audit: nil,
        notes: "Notes",
        description: "Description",
        file_upload: "File Upload"
      )
    ])
  end

  it "renders a list of followupaudits" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Notes".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "File Upload".to_s, count: 2
  end
end
