require 'rails_helper'

RSpec.describe "dak_templates/index", type: :view do
  before(:each) do
    assign(:dak_templates, [
      DakTemplate.create!(
        description: "Description",
        file_upload: "File Upload"
      ),
      DakTemplate.create!(
        description: "Description",
        file_upload: "File Upload"
      )
    ])
  end

  it "renders a list of dak_templates" do
    render
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "File Upload".to_s, count: 2
  end
end
