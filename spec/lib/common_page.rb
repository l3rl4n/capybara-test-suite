class CommonPage
  include Capybara::DSL

  def goto link
    click_link link
    assert_selector('h3', text:link, visible:true)
  end

end