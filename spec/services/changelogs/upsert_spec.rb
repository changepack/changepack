require 'rails_helper'

describe Changelogs::Upsert do
  describe '#perform' do
    let(:changelog) { build(:changelog) }
    let(:title) { 'Title' }
    let(:content) { 'Content' }
    let(:published) { 'on' }
    let(:params) do
      {
        changelog: changelog,
        title: title,
        content: content,
        published: published
      }
    end

    subject { described_class.new(params) }

    context 'when inserting' do
      it 'creates a changelog' do
        expect { subject.perform }.to change(Changelog, :count).by(1)
      end

      it 'sets status to published' do
        expect { subject.perform }.to change { changelog.status }.from('draft').to('published')
      end
    end

    context 'when updating' do
      let(:changelog) { create(:changelog) }
      let(:title) { 'Updated title' }
      let(:published) { nil }

      before { changelog.transition_to!(:published) }

      it 'assigns new attributes to a changelog' do
        expect { subject.perform }.to change { changelog.title }.from('Title').to('Updated title')
      end

      it 'sets status back to draft' do
        expect { subject.perform }.to change { changelog.status }.from('published').to('draft')
      end
    end
  end
end
