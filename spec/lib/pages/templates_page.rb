class TemplatesPage < CommonPage

  def page_title; 'SalesLoft Cadence' end

  def verify_page link='Templates'
    assert_title(page_title)
    verify_link(link)
  end

  def verify_link link
    link_found = find_link(link).visible?
    raise "\nCould not find the #{link} link after logging in. Check credentials and whats passed in rake task\n\n" unless link_found
  end

end