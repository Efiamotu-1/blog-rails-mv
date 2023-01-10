require 'rails_helper'

RSpec.describe User, type: :models do
  person = User.new(name: 'johnson', photo: 'https://unsplash.new_image.com', bio: 'Teacher from Mexico',
                    posts_counter: 1)

  it 'name should be present' do
    person.name = nil
    expect(person).to_not be_valid
  end

  it 'posts counter should be an integer' do
    person.posts_counter = '10'
    expect(person).to_not be_valid
  end

  context 'Associations' do
    it 'has many posts' do
      user = User.reflect_on_association('posts')
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association('comments')
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association('likes')
      expect(user.macro).to eq(:has_many)
    end
  end

  context 'Custom methods' do
    it 'returns recent posts' do
      user01 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                           posts_counter: 0)
      7.times do
        Post.create(user: user01, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
      end
      expect(user01.three_recent_posts).to match_array(user01.posts.last(3))
    end
  end
end
