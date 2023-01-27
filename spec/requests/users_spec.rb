require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  before(:example) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
  end

  it 'renders posts of a user' do
    get users_path

    expect(response).to have_http_status(:ok)

    expect(response).to render_template(:index)

    expect(response.body).to include('Show All users:')
  end
end
