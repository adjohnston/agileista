# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def current_user
    current_person
  end

  def account_switcher_selected(here, there)
    here == there ? "selected=\"selected\"" : ""
  end

  def show_stakeholder(user_story)
    if !user_story.stakeholder.blank?
      return "#{user_story.stakeholder}"
    elsif user_story.person
      "#{user_story.person.name}"
    else
      return "Unknown"
    end
  end

  def show_story_points(points, opts = {})
    options = {:unit => "story point"}.merge(opts)
    css_class = ['label', 'round', 'points']
    if points.nil?
      points = '?'
      css_class << 'secondary'
    end
    output = pluralize(points, options[:unit])

    if options[:badge]
      content_tag :span, :class => css_class.join(' ') do
        output
      end
    else
      output
    end
  end

  def show_assignees(developers)
    if developers.any?
      return developers.map(&:name).join(', ')
    else
      return "Nobody"
    end
  end

  def show_date(date)
    date.strftime("%d %B %Y")
  end

  def show_date_and_time(date)
    date.strftime("%d %b %y %H:%M %p")
  end

  def complete?(user_story)
    return ' class="uscomplete"' if user_story.complete?
  end

  def claimed?(user_story)
    return ' class="usclaimed"' if user_story.inprogress?
  end

  def claimed_or_complete?(user_story)
    return ' class="uscomplete"' if user_story.complete?
    return ' class="usclaimed"' if user_story.inprogress?
  end

  def display_themes(account, current_themes)
    result = []

    account.themes.collect do |theme|
      checkbox = check_box_tag("user_story[theme_ids][]", theme.id, (true if current_themes.include?(theme)), :id => sanitize_to_id(theme.name), :class => "checkbox")
      label = label_tag(theme.name, nil, :class => "checkbox")

      result << "<div>#{checkbox} #{label}</div>"
    end

    return result.join("\n").html_safe
  end

  def confirmation_message(object, name)
    "This cannot be undone. Are you sure you want to delete #{object} '#{name}'?"
  end

  def user_story_state(state)
    mapping = {
      :clarify => '',
      :criteria => 'alert',
      :estimate => 'secondary',
      :plan => 'success'
    }
    %[<span class="label #{mapping[state.to_sym]} fixed-width-label">#{state.titleize}</span>].html_safe
  end

  def pagination_info(entries, name = "entries")
    "<strong class=\"hightlight\">#{number_with_delimiter(entries.offset + 1)} - #{number_with_delimiter(entries.offset + entries.length)}</strong> of <strong>#{pluralize(content_tag(:strong, number_with_delimiter(entries.total_entries)), name)}</strong>" if entries
  end


  protected

  def build_link(link)
    match = link[:match] || link[:name]
    content_tag(
      :li,
      link_to(
        link[:name].titleize,
        link[:url],
        ({:class => link[:class]} if link[:class])
      ),
      :class => "#{link[:name].gsub(/\s/, '_')}#{' active' if active?(match)}"
    )
  end

  def active?(match)
    if match.is_a?(Array)
      match.any? {|match| page_signature.include?(match)}
    else
      page_signature.include?(match)
    end
  end

  def current_sprint
    @current_sprint ||= @account.sprints.current.first if @account
  end
end

