# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoutesHelper do
  let(:post) { create(:post) }
  let(:newsletter) { create(:newsletter) }

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

  describe '#scoped_newsletter_path' do
    it 'returns domain newsletter path when subdomain is present' do
      allow(request).to receive(:subdomain).and_return('subdomain')
      expect(scoped_newsletter_path(newsletter)).to eq(domain_newsletter_path(newsletter))
    end

    it 'returns account newsletter path when subdomain is not present' do
      allow(request).to receive(:subdomain).and_return('')
      expect(scoped_newsletter_path(newsletter)).to eq(account_newsletter_path(newsletter.account, newsletter))
    end
  end

  describe '#scoped_newsletter_url' do
    it 'returns domain newsletter url when subdomain is present' do
      allow(request).to receive(:subdomain).and_return('subdomain')
      expect(scoped_newsletter_url(newsletter)).to eq(domain_newsletter_url(newsletter))
    end

    it 'returns account newsletter url when subdomain is not present' do
      allow(request).to receive(:subdomain).and_return('')
      expect(scoped_newsletter_url(newsletter)).to eq(account_newsletter_url(newsletter.account, newsletter))
    end
  end
end
