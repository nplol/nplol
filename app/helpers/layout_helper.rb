module LayoutHelper

  def get_layout
    return 'article-view' if @post
    'listing-view'
  end

end
