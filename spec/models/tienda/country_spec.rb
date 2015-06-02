require 'spec_helper'

module Tienda
  describe Country do
    context 'validations' do
      it 'has a valid factory' do
        expect(build(:country)).to be_valid
      end
      it 'is invalid without a name' do
        expect(build(:country, name: nil)).not_to be_valid
      end
    end
  end
end
