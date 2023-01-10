require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:example) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
  end
  post = Post.new(title: 'hello world', text: 'this is my first post', comments_counter: 1, likes_counter: 1)

  it 'title should be present' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'title should not be too long' do
    post.title = 'a' * 250
    expect(post).to_not be_valid
  end

  it 'comments counter should be an integer' do
    post.comments_counter = '1'
    expect(post).to_not be_valid
  end

  it 'likes counter should be an integer' do
    post.likes_counter = true
    expect(post).to_not be_valid
  end

  it 'comments counter should not be less than zero' do
    post.comments_counter = -1
    expect(post).to_not be_valid
  end

  it 'likes counter should not be less than zer' do
    post.likes_counter = -3
    expect(post).to_not be_valid
  end

  context 'Associations' do
    it 'belongs to an author' do
      post = Post.reflect_on_association('user')
      expect(post.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      post = Post.reflect_on_association('comments')
      expect(post.macro).to eq(:has_many)
    end

    it 'has many likes' do
      post = Post.reflect_on_association('likes')
      expect(post.macro).to eq(:has_many)
    end
  end

  context 'Custom methods' do
    it 'returns recent comments' do
      post = Post.create(user: @user, title: 'Post communication', text: 'This is my first post', likes_counter: 0,
                         comments_counter: 0)
      8.times { Comment.create(post:, user: @user, text: 'Hi Tom!') }
      expect(post.five_recent_comments).to match_array(post.comments.last(5))
    end

    it 'updates posts_counter of the author' do
      Post.create(user: @user, title: 'Post communication', text: 'This is my first post', likes_counter: 0,
                  comments_counter: 0)
      expect(@user.posts_counter).to eq 1
    end
  end
end
