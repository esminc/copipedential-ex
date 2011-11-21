module ApplicationHelper
  def user_mini_link(user, size = 24)
    hostname = request.ssl? ? 'secure.gravatar.com' : 'www.gravatar.com'
    gravatar = "#{request.protocol}#{hostname}/avatar/#{user.gravatar}?s=#{size}"

    link_to user.nickname, user, style: "background-image: url(#{gravatar})", class:'user-mini'
  end

  def with_paging(objects, &block)
    pagination = paginate(objects)
    content = capture(&block)

    pagination + content + pagination
  end
end
