module ApplicationHelper
  def my_name
    'Or Bar-Tal'
  end

  def form_group_tag(errors)
    if errors.any?
      "form-group has-error"
    else
      "form-group"
    end
  end
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

  def up_vote_link_classes(post)
    "glyphicon glyphicon-chevron-up #{(current_user.voted(post) && current_user.voted(post).up_vote?) ? 'voted' : '' }"
  end

  def down_vote_link_classes(post)
    "glyphicon glyphicon-chevron-down #{(current_user.voted(post) && current_user.voted(post).down_vote?) ? 'voted' : '' }"
  end
end
