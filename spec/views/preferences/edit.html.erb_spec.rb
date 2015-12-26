require 'rails_helper'

RSpec.describe "preferences/edit", type: :view do
  before(:each) do
    @preference = assign(:preference, Preference.create!())
  end

  it "renders the edit preference form" do
    render

    assert_select "form[action=?][method=?]", preference_path(@preference), "post" do
    end
  end
end
