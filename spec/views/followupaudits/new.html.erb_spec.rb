require 'rails_helper'

RSpec.describe "followupaudits/new", type: :view do
  before(:each) do
    assign(:followupaudit, Followupaudit.new(
      internal_audit: nil,
      notes: "MyString",
      description: "MyString",
      file_upload: "MyString"
    ))
  end

  it "renders new followupaudit form" do
    render

    assert_select "form[action=?][method=?]", followupaudits_path, "post" do

      assert_select "input[name=?]", "followupaudit[internal_audit_id]"

      assert_select "input[name=?]", "followupaudit[notes]"

      assert_select "input[name=?]", "followupaudit[description]"

      assert_select "input[name=?]", "followupaudit[file_upload]"
    end
  end
end
