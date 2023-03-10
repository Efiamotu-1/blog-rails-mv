require 'rails_helper'

RSpec.describe 'Posts controller', type: :request do
  before(:example) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    Post.create(user: @user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                comments_counter: 0)
  end

  it 'renders posts of a user' do
    get "/users/#{@user.id}/posts"

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:index)

    expect(response.body).to include('All posts for User')
  end

  it 'renders a page for specific post' do
    post = Post.create(user: @user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                       comments_counter: 0)
    get "/users/#{@user.id}/posts/#{post.id}"

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:show)

    expect(response.body).to include('Single post')
  end
end
