require 'spec_helper'

module Tienda
  describe User do
    context 'validations' do
      it 'has a valid factory' do
        expect(build(:user)).to be_valid
      end
      it 'is invalid without a first name' do
        expect(build(:user, first_name: nil)).not_to be_valid
      end
      it 'is invalid without a last name' do
        expect(build(:user, last_name: nil)).not_to be_valid
      end
      it 'is invalid without an email address' do
        expect(build(:user, email_address: nil)).not_to be_valid
      end
    end

    context 'instance methods' do
      let(:user) { create(:user) }
      it { is_expected.to respond_to(:full_name) }
      it { is_expected.to respond_to(:short_name) }
      it { is_expected.to respond_to(:reset_password!) }
      it 'full_name works as expected' do
        expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
      end
      it 'short_name works as expected' do
        expect(user.short_name).to eq("#{user.first_name} #{user.last_name[0, 1]}")
      end
      it 'resets user password' do
        expect { user.reset_password! }.to change(user, :password)
      end
      context 'class methods' do
        let(:user) { create(:user) }
        it 'authenticates valid user' do
          expect(User.authenticate(user.email_address, user.password)).to be_a(User)
        end
      end
    end
  end
end
