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
end
