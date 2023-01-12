require 'rails_helper'

RSpec.describe User, type: :request do
  it 'shows correct response status for index page' do
    get users_path
    expect(response).to have_http_status(:ok)
  end

  it 'shows correct response status for show page' do
    get user_path(2)
    expect(response).to have_http_status(:ok)
  end

  it 'renders the index.html.erb for all users' do
    get users_path
    expect(response).to render_template('index')
  end

  it 'renders the show.html.erb for a single user' do
    get user_path(3)
    expect(response).to render_template('show')
  end

  it 'response body includes correct placeholder text' do
    get users_path
    expect(response.body).to include('Show All users:')
  end
end
