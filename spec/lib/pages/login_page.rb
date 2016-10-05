class LoginPage < CommonPage
  include Capybara::DSL

  def visit_page
    # Just in case you wanted to use the base_url, which Im not :)
    visit ENV['base_url'] || 'http://accounts.salesloft.com/sign_in'
    assert_title('SalesLoft')
  end

  def verify_page
    expect(page.title).to eq('SalesLoft')
  end

  def login(email='luggage@spaceballs.net', password='12345')
    unless ENV['email']
      print "\nI noticed you are going to use the parameter defaults when trying to login, which wont actually work.
      Try rerunning this again with:
      - rake email=real_email@aol.com password=Op3nSes4me\n\n".red
    end
    fill_in 'Email',    with: ENV['email']    || email
    fill_in 'Password', with: ENV['password'] || password
    click_button 'Login'
    assert_title('SalesLoft Cadence')
    template_link_found = find_link('Templates').visible?
    raise "\nCould not find the Templates link after logging in. Check credentials and whats passed in rake task\n\n" unless template_link_found
  end

end