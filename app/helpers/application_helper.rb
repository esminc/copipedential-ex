module ApplicationHelper
  def user_mini_link(user, size = 24)
    g = gravatar(user, size)
    link_to user.nickname, user, style: "background-image: url(#{g})", class:'user-mini'
  end

  def gravatar(user, size)
    "#{request.protocol}www.gravatar.com/avatar/#{user.gravatar}?s=#{size}"
  end

  def with_paging(objects, &block)
    pagination = paginate(objects)
    content = capture(&block)

    pagination + content + pagination
  end
end
