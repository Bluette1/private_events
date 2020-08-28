require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject do
      described_class.new(name: 'name')
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name) }

    it 'is not valid without the minimum length of name' do
      subject.name = 'n'
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:created_events) }
    it { should have_many(:attended_events) }
    it { should have_many(:event_attendances) }
  end
end
