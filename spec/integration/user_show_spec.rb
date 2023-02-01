require 'rails_helper'

RSpec.describe 'User Show Page (Assert)', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/512/User-icon.png',
                        bio: 'Physics Teacher',
                        posts_counter: 0)
    @post1 = Post.create(user: @user, title: 'Welcome', text: 'this is the first test post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(user: @user, title: 'Welcome home', text: 'this is the second test post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(user: @user, title: 'Welcome here', text: 'this is the third test post', likes_counter: 0,
                         comments_counter: 0)
    visit user_path(@user.id)
  end

  describe 'Show page' do
    scenario 'renders the correct users name and bio' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.bio)
    end

    scenario 'shows the proper user photo' do
      expect(page.body).to include('https://icons.iconarchive.com/icons/iconsmind/outline/512/User-icon.png')
    end

    scenario 'renders the users number of posts' do
      expect(page).to have_content("Number of posts: #{@user.posts_counter}")
    end

    scenario 'renders the users last three posts' do
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
    end

    scenario 'see all posts button' do
      expect(page).to have_link('See all posts')
    end
  end
end

RSpec.describe 'User Show Page (Redirect)', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Physics Teacher',
                        posts_counter: 0)
    @post = Post.create(user: @user, title: 'Welcome', text: 'this is a test post', likes_counter: 0,
                        comments_counter: 0)
    visit user_path(@user.id)
  end

  describe 'Show page' do
    scenario 'user is redirected to the post show page' do
      click_link(@post.title)
      expect(current_path).to match user_post_path(@user, @post)
    end

    scenario 'user is redirected to see all posts made by a single user' do
      click_link('See all posts')
      sleep(4)
      expect(current_path).to match user_posts_path(@user)
    end
  end
end
