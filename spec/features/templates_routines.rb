require 'spec_helper'

feature 'Login to SalesLoft Account' do

  let(:login_page)     { LoginPage.new     }
  let(:templates_page) { TemplatesPage.new }

  background do
    login_page.visit_page
  end

  scenario 'Check out all the fun stuff on the templates page' do

    login_page.login
    login_page.goto('Templates')

    templates_page.verify_page
    templates_page.clear_templates if templates_page.number_of_templates >= 1

    templates_page.add_new_template


    binding.pry
  end

end
