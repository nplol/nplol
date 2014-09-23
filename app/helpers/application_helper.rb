module ApplicationHelper

  def nplol?
    current_user && current_user.nplol?
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find session[:user_id]
  end

  def post_like_icon(post, liked)
    if liked
      content_tag(:i, "", class: "fa fa-heart fa-lg liked", title: 'You like this') +
      content_tag(:span, post.likes.count)
    else
      if post.likes.count > 0
        content_tag(:i, "", class: "fa fa-heart fa-lg", title: 'Like post') +
        content_tag(:span, post.likes.count)
      else
        content_tag(:i, "", class: "fa fa-heart-o", title: 'Like this')
      end
    end
  end

end
