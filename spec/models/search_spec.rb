require 'rails_helper'

describe Search do
  subject(:search) { Search.new(query) }

  let(:alice) { User.create(name: 'Alice', location: 'Anchorage') }
  let(:bob) { User.create(name: 'Bob', location: 'Boston') }
  let(:charlie) { User.create(name: 'Charlie', location: 'Chicago') }
  let(:users) { [alice, bob, charlie] }

  # Force user creation
  let!(:data) { users }

  before do
    Sunspot.commit
  end

  describe 'searching for users' do
    subject(:results) { search.users }
    context 'when searching by location' do
      let(:query) { 'Chicago' }
      it { is_expected.to match_array [charlie] }
    end
  end
end
