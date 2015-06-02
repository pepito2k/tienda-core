require 'spec_helper'

module Tienda
  describe TaxRate do
    context 'validations' do
      it 'has a valid factory' do
        expect(build(:tax_rate)).to be_valid
      end
      it 'is invalid without a name' do
        expect(build(:tax_rate, name: nil)).not_to be_valid
      end
      it 'is invalid with a non-number rate' do
        expect(build(:tax_rate, rate: 'RATE')).not_to be_valid
      end
      it 'is invalid with an unexpected address_type' do
        expect(build(:tax_rate, address_type: 'party')).not_to be_valid
      end
    end

    context 'instance methods' do
      let(:tax_rate) { create(:tax_rate, address_type: 'billing') }
      it { is_expected.to respond_to(:name) }
      it { is_expected.to respond_to(:address_type) }
      it { is_expected.to respond_to(:rate) }
      it { is_expected.to respond_to(:products) }
      it { is_expected.to respond_to(:delivery_service_prices) }
      it { is_expected.to respond_to(:description) }
      it { is_expected.to respond_to(:rate_for) }
      it 'description works as expected' do
        expect(tax_rate.description).to eq('Standard Tax (20.0%)')
      end
      pending 'rate_for order works as expected' do
        expect(tax_rate.rate_for).to eq(20.0)
      end
    end
  end
end
