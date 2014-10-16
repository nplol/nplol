module ApplicationHelper

  def like_icon(post, liked)
    liked ? title = 'You like this.' : title = 'Like post'
    content_tag(:i, '', class: "fa fa-heart #{'liked' if liked}", title: title)
  end

  def like_count(post)
    content_tag(:span, post.likes.count, class: 'attention', 
                title: post.liking_users.map(&:name).join(', ')) + 
    content_tag(:span, ' user(s) like this post.')
  end 

end
