spec/controllers/sources_controller_spec.rb
</new_file>

```ruby
require 'rails_helper'

RSpec.describe SourcesController, type: :controller do
  describe 'GET #index' do
    it 'authorizes the user' do
get :index
expect(response).to have_http_status(:success)
      # Add test here
    end

    it 'paginates the sources' do
10.times { Source.create }
get :index, params: { page: 2 }
expect(assigns(:sources).length).to eq(5)
      # Add test here
    end

    it 'renders the sources' do
get :index
expect(response).to render_template(:index)
      # Add test here
    end
  end

  describe '#collection' do
    it 'fetches the authorized sources that are kept and have activity' do
Source.create(active: true)
get :collection
expect(assigns(:sources).length).to eq(1)
      # Add test here
    end
  end
end
```
