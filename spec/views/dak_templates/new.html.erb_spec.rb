require 'rails_helper'

RSpec.describe "dak_templates/new", type: :view do
  before(:each) do
    assign(:dak_template, DakTemplate.new(
      description: "MyString",
      file_upload: "MyString"
    ))
  end

  it "renders new dak_template form" do
    render

    assert_select "form[action=?][method=?]", dak_templates_path, "post" do

      assert_select "input[name=?]", "dak_template[description]"

      assert_select "input[name=?]", "dak_template[file_upload]"
    end
  end
end
