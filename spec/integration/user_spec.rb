require 'rails_helper'

RSpec.describe 'User', type: :system do
  before do
    visit users_path
  end
  scenario 'show all users' do
    expect(page).to have_content('Users')
  end
end
