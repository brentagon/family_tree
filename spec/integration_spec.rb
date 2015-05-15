require('capybara/rspec')
require('spec_helper')
require('./app')
Capybara.app = Sinatra::Application

describe('salon management app') do

  describe('index get', {:type => :feature}) do
    it('Displays index page') do
      visit('/')
      expect(page).to have_content('Family Tree')
    end
  end

describe('a long path through the application', {:type => :feature}) do
  it('click through the application, adding and displaying many things') do
    visit('/')
    fill_in("name", {:with =>"Jacob"})
    click_button("Add person")
    expect(page).to have_content("Jacob")
    click_link("View person")
    expect(page).to have_content ("Update Jacob")
    fill_in("new_child", {:with => "Susie Q"})
  end
end

end
