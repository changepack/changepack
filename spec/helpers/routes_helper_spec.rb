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
describe '#scoped_post_url' do
    it 'returns domain post url when subdomain is present' do
      allow(request).to receive(:subdomain).and_return('subdomain')
      expect(scoped_post_url(post)).to eq(domain_post_url(post))
    end

    it 'returns account post url when subdomain is not present' do
      allow(request).to receive(:subdomain).and_return('')
      expect(scoped_post_url(post)).to eq(account_post_url(post.account, post))
    end
  end

  describe '#scoped_changelog_path' do
    it 'returns domain changelog path when subdomain is present' do
      allow(request).to receive(:subdomain).and_return('subdomain')
      expect(scoped_changelog_path(changelog)).to eq(domain_changelog_path(changelog))
    end

    it 'returns account changelog path when subdomain is not present' do
      allow(request).to receive(:subdomain).and_return('')
      expect(scoped_changelog_path(changelog)).to eq(account_changelog_path(changelog.account, changelog))
    end
  end

  describe '#scoped_changelog_url' do
    it 'returns domain changelog url when subdomain is present' do
      allow(request).to receive(:subdomain).and_return('subdomain')
      expect(scoped_changelog_url(changelog)).to eq(domain_changelog_url(changelog))
    end

    it 'returns account changelog url when subdomain is not present' do
      allow(request).to receive(:subdomain).and_return('')
      expect(scoped_changelog_url(changelog)).to eq(account_changelog_url(changelog.account, changelog))
    end
  end
end
end
```
