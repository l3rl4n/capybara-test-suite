class LoginPage < CommonPage
  include Capybara::DSL

  def page_title;         'SalesLoft'                                 end

  def email_input;        find('input#user_email')                    end
  def password_input;     find('input#user_password')                 end

  def set_email(text);    email_input.set(ENV['email'] || text)       end
  def set_password(text); password_input.set(ENV['password'] || text) end
  def click_login;        click_button 'Login'                        end

  def visit_page
    # Just in case you wanted to use the base_url, which Im not :)
    url = ENV['base_url'] ?
            (ENV['base_url'] + '/sign_in') :
            'http://accounts.salesloft.com/sign_in'
    visit url
    assert_title(page_title)
  end

  def login(email='luggage@spaceballs.net', password='12345')
    return if already_logged_in
    unless ENV['email']
      print "\nI noticed you are going to use the parameter defaults when trying to login, which wont actually work.
      Try rerunning this again with:
      - rake email=real_email@aol.com password=Op3nSes4me\n\n".red
    end
    user = User.new(email, password)
    set_email user.email
    set_password user.password
    click_login
  end

  def already_logged_in
    has_no_field?('Email') and find('i.fa-user').visible?
  end


end