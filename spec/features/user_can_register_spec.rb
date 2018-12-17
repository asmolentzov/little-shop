require 'rails_helper'

describe 'as a visitor, when I visit /' do
  describe 'and I click on the register link' do
    it 'takes me to a page with a registration form' do
      visit '/'

      click_on 'Register'

      expect(current_path).to eq(new_user_path)
    end
    describe 'when I fill out the form and click submit' do
      it 'logs me in and takes me to my profile page' do

      end
    end
  end
end
