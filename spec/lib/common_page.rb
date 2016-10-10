class CommonPage
  include Capybara::DSL

  def goto link
    click_link link
    assert_selector('h3', text:link, visible:true)
  end

  def find_where_devs_helped_out
    all("[class*='qa']").each do |element|
      str = ''
      [:class, :name, :id, :href, :title].each do |attribute|
        # print "Checking #{attribute} for #{element.tag_name} - #{element[attribute]}\n".yellow
                                                                          # It's nil, empty, or just whitespace
        str << (attribute.to_s + ':"' + element[attribute] + '" ') unless element[attribute].to_s.empty?
      end
      print "#{element.tag_name} - #{str}\n".cyan
    end
  end

end