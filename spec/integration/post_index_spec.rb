require 'rails_helper'

RSpec.describe 'Post Index Test (Assert)', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Physics Teacher',
                        posts_counter: 0)
    @post = Post.create(user: @user, title: 'Welcome', text: 'this is the first test post', likes_counter: 0,
                        comments_counter: 0)
    5.times { Comment.create(text: 'Nice post!!', user_id: @user.id, post_id: @post.id) }
    visit user_posts_path(@user.id)
  end

  describe 'Post Index' do
    scenario "shows the user's username" do
      expect(page).to have_content(@user.name)
    end

    scenario 'shows the proper user photo' do
      expect(page.body).to include('https://icons.iconarchive.com/icons/iconsmind/outline/512/User-icon.png')
    end

    scenario 'displays post text' do
      expect(page).to have_content('this is the first test post')
    end

    scenario 'display the post title' do
      expect(page).to have_content(@post.title)
    end

    scenario 'display the post body' do
      expect(page).to have_content(@post.text)
    end

    scenario 'display the first comment on a post' do
      expect(page).to have_content('Nice post!!')
    end

    scenario 'display the how many comments' do
      expect(page).to have_content('Comments: 5')
    end

    scenario 'display the how many Likes' do
      expect(page).to have_content('Likes: 0')
    end

    scenario 'redirect to post show page when a post is clicked' do
      click_link(@post.title)
      expect(current_path) == (user_post_path(@user, @post))
    end
  end
end
