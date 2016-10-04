require 'spec_helper'

feature 'Login to SalesLoft Account' do

  let(:email)    { 'brian@aol.com'      }
  let(:password) { 'super_duper_secret' }

  background do
    visit 'http://accounts.salesloft.com/sign_in'
  end

  scenario 'Login to my account' do
    expect(page.title).to eq('SalesLoft')
    page.fill_in 'Email',    :with => ENV['EMAIL']    || email
    page.fill_in 'Password', :with => ENV['PASSWORD'] || password
    click_button 'Login'
  end

end
