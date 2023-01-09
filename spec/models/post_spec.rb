require 'rails_helper'

RSpec.describe Post, type: :model do
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
end
