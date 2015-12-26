require 'rails_helper'

RSpec.describe "preferences/index", type: :view do
  before(:each) do
    assign(:preferences, [
      Preference.create!(),
      Preference.create!()
    ])
  end

  it "renders a list of preferences" do
    render
  end
end
