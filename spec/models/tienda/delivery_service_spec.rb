require 'spec_helper'

module Tienda
  describe DeliveryService do
    context 'validations' do
      it 'has a valid factory' do
        expect(build(:delivery_service)).to be_valid
      end
      it 'is invalid without a name' do
        expect(build(:delivery_service, name: nil)).not_to be_valid
      end
      it 'is invalid without a courier' do
        expect(build(:delivery_service, courier: nil)).not_to be_valid
      end
    end

    context 'instance methods' do
      xit 'gets tracking url for order' do
        pending 'Still missing order tests'
      end
    end
  end
end
