require 'rails_helper'

RSpec.describe "dak_templates/edit", type: :view do
  before(:each) do
    @dak_template = assign(:dak_template, DakTemplate.create!(
      description: "MyString",
      file_upload: "MyString"
    ))
  end

  it "renders the edit dak_template form" do
    render

    assert_select "form[action=?][method=?]", dak_template_path(@dak_template), "post" do

      assert_select "input[name=?]", "dak_template[description]"

      assert_select "input[name=?]", "dak_template[file_upload]"
    end
  end
end
