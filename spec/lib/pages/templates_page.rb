class TemplatesPage < CommonPage

  def page_title; 'SalesLoft Cadence' end

  # Header
  def profile_dropdown;              find('i.fa-user')                        end

  # Template Window
  def select_all_templates;          first('input.sl-checkbox').set(true)     end
  def number_of_templates;           all('td.template-checkboxes').size       end
  def trash_can;                     find('i.qa-template-delete')             end
  def confirm_delete;                find('a.btn-warning')                    end

  def template_actions;              find('a.qa-template-actions')            end
  def add_template;                  find('a.qa-template-create')             end
  def export_template;               find('a.qa-template-export')             end

  # New Template
  def template_name;                 find('input.qa-template-input-name')     end
  def template_subject;              find('input.qa-template-input-subject')  end
  def template_body;                 find('div.note-editable')                end
  def insert_dynamic_field_dropdown; find('i.qa-dynamic-tags-button').click   end
  def save_template;                 find('a.qa-template-save').click         end

  def check_all_dynamic_data_is_available debug = false
    str   = ''
    data  = YAML::load(File.open('config/templates.yml'))

    insert_dynamic_field_dropdown
    data['dynamic_values'].keys.each do |key|
      print "appending data for #{key}\n".green if debug

      # Add a space between types (personal, company, misc and optout link)
      str << ' ' unless str.empty?

      # format personal_data -> Personal Data
      str << key.split('_').map(&:capitalize).join(' ')
      data['dynamic_values'][key].keys.each do |dynamic_item|
        print "adding key #{dynamic_item}\n".yellow if debug
        str << (key[/misc/] ?
                  " #{dynamic_item}" :
                  " {{#{dynamic_item}}}")
      end
    end
    assert_text(:visible, str, { count:1 })
  end

  def add_new_template options
    open_new_template
    fill_in_template options
    save_template
  end

  def open_new_template
    template_actions.click
    add_template.click
  end

  def fill_in_template options
    [:name, :subject, :body].each do |input|
        self.send("template_#{input}").set options[input]
    end
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