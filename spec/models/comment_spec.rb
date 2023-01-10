require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Testing the comment model' do
    it 'is valid with valid attributes' do
      @user01 = User.create(name: 'pires', photo: 'https://image.com/01.jpg', bio: 'Born in USA', posts_counter: 0)
      @post01 = Post.create(user_id: @user01.id, title: 'Hello Mark', text: 'What about you ?', likes_counter: 1,
                            comments_counter: 1)
      expect(@post01).to be_valid
    end

    it 'update_comments_counter' do
      @user01 = User.create(name: 'pires', photo: 'https://image.com/01.jpg', bio: 'Born in USA', posts_counter: 0)
      @post01 = Post.create(user_id: @user01.id, title: 'Hello Mark', text: 'What about you ?', likes_counter: 1,
                            comments_counter: 1)
      Comment.create(user_id: @user01.id, post_id: @post01.id, text: 'Now working in dev')
      expect(@post01.comments_counter).to eq 1
    end
  end
end
