require 'rails_helper'

RSpec.describe 'User Index Asserts', type: :system do
  before :each do
    @user1 = User.create(name: 'Chris stapleton', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/512/User-icon.png',
                         bio: 'I am a Country musician', posts_counter: 6)
    @user2 = User.create(name: 'Mylie cyrus', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/512/User-icon.png',
                         bio: 'I am a pop artiste', posts_counter: 9)
  end

  describe 'index page' do
    it 'shows the right content' do
      visit root_path
      expect(page).to have_content('Users')
    end
  end

  scenario 'shows all created users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  scenario 'renders the user post count' do
    visit users_path
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
  end
end

RSpec.describe 'User Index Redirects', type: :system do
  describe 'Index Page' do
    before :each do
      @current_user = User.create(name: 'Habeeb Efiamotu', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/512/User-icon.png',
                                  bio: 'I am a software developer', posts_counter: 2)
    end

    scenario 'renders the user' do
      visit users_path
      click_link(@current_user.name)
      sleep(1)
      expect(current_path).to match user_path(@current_user)
    end
  end
end
