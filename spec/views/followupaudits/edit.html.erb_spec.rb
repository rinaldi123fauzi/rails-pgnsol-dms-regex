require 'rails_helper'

RSpec.describe "followupaudits/edit", type: :view do
  before(:each) do
    @followupaudit = assign(:followupaudit, Followupaudit.create!(
      internal_audit: nil,
      notes: "MyString",
      description: "MyString",
      file_upload: "MyString"
    ))
  end

  it "renders the edit followupaudit form" do
    render

    assert_select "form[action=?][method=?]", followupaudit_path(@followupaudit), "post" do

      assert_select "input[name=?]", "followupaudit[internal_audit_id]"

      assert_select "input[name=?]", "followupaudit[notes]"

      assert_select "input[name=?]", "followupaudit[description]"

      assert_select "input[name=?]", "followupaudit[file_upload]"
    end
  end
end
