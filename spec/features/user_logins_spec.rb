require 'rails_helper'

RSpec.feature "Login redirect", type: :feature, js: true do

# SETUP
  before :each do
    User.create!(password:"password", email:"user@email.com", first_name:"bob", last_name: "bobby")
  end

  scenario "They click on the login button" do
    # ACT
    visit login_path

    fill_in :email, with: "user@email.com"
    fill_in :password, with: "password"
    click_on "Submit"

    # DEBUG
    #

    # VERIFY
    expect(page).to have_text 'Signed in as'
    save_screenshot
  end
end