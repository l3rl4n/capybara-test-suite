require 'spec_helper'

feature 'Login to my SalesLoft Account' do

  let(:login_page)     { LoginPage.new     }
  let(:templates_page) { TemplatesPage.new }
  let(:options)        {{ debug: true }}

  background do
    login_page.visit_page
    login_page.login
    login_page.goto('Templates')
  end

  scenario 'and load my speedtest chrome extension' do
    binding.pry
    puts 'sd'
  end

  scenario 'and make sure the login page has the correct title and the Templates link' do
    templates_page.verify_page
  end

  scenario 'then I delete any templates if any exist' do
    templates_page.clear_templates if templates_page.number_of_templates >= 1
    expect(page).to have_css('div.no-results-notice', text: 'There are no templates that match your filter settings')
  end

  scenario 'and I add a new template' do
    template_options = {
      name:    'my first template',
      subject: 'Coolest Subject Around',
      body:    'Lorem Ipsum dummy text'
    }
    templates_page.add_new_template options.merge(template_options)
    expect(page).to have_css('td.qa-template-title',           text: options[:name])
    expect(page).to have_css('span.template-content--subject', text: options[:subject])
    expect(page).to have_css('span.template-content--body',    text: options[:body])
  end

  scenario 'and I verify all the dynamic content hasnt changed' do
    templates_page.open_new_template
    templates_page.check_all_dynamic_data_is_available options[:debug]

  end

end
