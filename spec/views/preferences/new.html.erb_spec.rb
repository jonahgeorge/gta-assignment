require 'rails_helper'

RSpec.describe "preferences/new", type: :view do
  before(:each) do
    assign(:preference, Preference.new())
  end

  it "renders new preference form" do
    render

    assert_select "form[action=?][method=?]", preferences_path, "post" do
    end
  end
end
