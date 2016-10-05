class TemplatesPage < CommonPage

  def page_title; 'SalesLoft Cadence' end

  def select_all_templates;      first(:input,'input.sl-checkbox').set(true) end
  def number_of_templates;       all('td.template-checkboxes').size          end
  def trash_can;                 find('i.qa-template-delete')                end
  def confirm_delete;            find('a.btn-warning')                       end

  def template_actions;          find('a.qa-template-actions')               end
  def add_template;              find('a.qa-template-create')                end
  def export_template;           find('a.qa-template-export')                end

  # New Template
  def set_template_name(text);   fill_in('title', with:text)                 end
  def set_template_subject(text) fill_in('emailSubject', with: text)         end

  def check_all_template_aspects index
    set_template_name("Template ##{index}")
    set_template_subject('Subject for Template #' + index.to_s)

    binding.pry
  end

  def add_new_template index=1
    template_actions.click
    add_template.click
    check_all_template_aspects index
  end

  def clear_templates
    select_all_templates
    trash_can.click
    confirm_delete.click
  end

  def verify_page link='Templates'
    assert_title(page_title)
    verify_link(link)
  end

  def verify_link link
    link_found = find_link(link).visible?
    raise "\nCould not find the #{link} link after logging in. Check credentials and whats passed in rake task\n\n" unless link_found
  end

end