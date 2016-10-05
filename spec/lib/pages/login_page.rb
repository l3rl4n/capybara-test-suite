class LoginPage < CommonPage
  include Capybara::DSL

  def email_text;    'Email'      end
  def password_text; 'Password'   end
  def login_text;    'Login'      end
  def page_title;    'SalesLoft'  end

  def visit_page
    # Just in case you wanted to use the base_url, which Im not :)
    url = ENV['base_url'] ?
            (ENV['base_url'] + '/sign_in') :
            'http://accounts.salesloft.com/sign_in'
    visit url
    assert_title(page_title)
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
    end

end