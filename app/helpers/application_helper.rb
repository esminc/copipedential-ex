module ApplicationHelper
  def user_mini_link(user, size = 24)
    g = gravatar(user, size)
    link_to user.nickname, user, style: "background-image: url(#{g})", class:'user-mini'
  end

  def gravatar(user, size)
    hostname = request.ssl? ? 'secure.gravatar.com' : 'www.gravatar.com'
    "#{request.protocol}#{hostname}/avatar/#{user.gravatar}?s=#{size}"
  end

  def with_paging(objects, &block)
    pagination = paginate(objects)
    content = capture { block.call(objects) }

    pagination + content + pagination
  end

  def t_with_default(word, scope = ['view', controller_name, action_name])
    key = word.sub(/\s+/, '_').underscore
    t(key, scope: scope, default: word)
  end
  alias t_wd t_with_default
end
