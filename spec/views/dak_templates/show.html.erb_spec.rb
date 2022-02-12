require 'rails_helper'

RSpec.describe "dak_templates/show", type: :view do
  before(:each) do
    @dak_template = assign(:dak_template, DakTemplate.create!(
      description: "Description",
      file_upload: "File Upload"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/File Upload/)
  end
end
