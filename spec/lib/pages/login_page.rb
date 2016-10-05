class LoginPage < CommonPage
  include Capybara::DSL

  def email_text;    'Email'             end
  def password_text; 'Password'          end
  def login_text;    'Login'             end
  def page_title;    'SalesLoft Cadence' end

  def visit_page
    # Just in case you wanted to use the base_url, which Im not :)
    visit ENV['base_url'] || 'http://accounts.salesloft.com/sign_in'
    assert_title('SalesLoft')
  end

  def login(email='luggage@spaceballs.net', password='12345')
    unless ENV['email']
      print "\nI noticed you are going to use the parameter defaults when trying to login, which wont actually work.
      Try rerunning this again with:
      - rake email=real_email@aol.com password=Op3nSes4me\n\n".red
    end
    fill_in email_text,    with: ENV['email']    || email
    fill_in password_text, with: ENV['password'] || password
    click_button login_text
    assert_title(page_title)
    verify_link('Templates')
    end

  def verify_link link
    link_found = find_link(link).visible?
    raise "\nCould not find the Templates link after logging in. Check credentials and whats passed in rake task\n\n" unless link_found
  end

end