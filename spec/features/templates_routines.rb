require 'spec_helper'

feature 'Login to SalesLoft Account' do

  let(:login_page) {  LoginPage.new       }

  background do
    login_page.visit_page
  end

  scenario 'Check out all the fun stuff on the templates page' do
    login_page.login
    login_page.goto('Templates')


    binding.pry
  end

end
