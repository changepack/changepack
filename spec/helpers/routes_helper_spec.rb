require 'rails_helper'

RSpec.describe RoutesHelper, type: :helper do
  let(:post) { create(:post) }
  let(:changelog) { create(:changelog) }

  describe '#scoped_post_path' do
    it 'returns domain post path when subdomain is present' do
      allow(request).to receive(:subdomain).and_return('subdomain')
      expect(scoped_post_path(post)).to eq(domain_post_path(post))
    end

    it 'returns account post path when subdomain is not present' do
      allow(request).to receive(:subdomain).and_return('')
      expect(scoped_post_path(post)).to eq(account_post_path(post.account, post))
    end
  end

  # Repeat similar tests for scoped_post_url, scoped_changelog_path, and scoped_changelog_url
end
```

