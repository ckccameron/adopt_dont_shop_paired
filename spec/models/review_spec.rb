#review model test

RSpec.describe Review do
  describe 'relationships' do
    it { should belong_to :shelter }
  end
end
