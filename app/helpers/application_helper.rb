module ApplicationHelper
  def user_mini_link(user, size = 24)
    gravatar = "http://www.gravatar.com/avatar/#{user.gravatar}?s=#{size}"
    link_to user.nickname, user, style: "background-image: url(#{gravatar})", class:'user-mini'
  end
end
