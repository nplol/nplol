module GridHelper

  def set_grid
    # no need for a grid when there're no posts, eh?
    return unless @posts.length > 0
    score(@posts)
    gridify(@posts)
  end

  private

  def score(posts)
    # 0 is the initial value
    avg_score = posts.reduce(0) { |total, post| total + post.score } / posts.length
    posts.map { |post| post.popular = true if post.score > avg_score }
  end

  # sort posts based on proper grid placement
  def gridify(posts)
    cand = nil
    toggle = 0
    while true do
      posts.each_slice(2) do |post, nxt|
        return if nxt.nil?
        if post.popular? && nxt.popular?
          if toggle == 0
            cand = post
            toggle = 1
          else
            cand = nxt
            toggle = 0
          end
          break
        end
      end
      return if cand.nil?
      swap_cand = posts.slice(posts.index(cand), posts.length).reject{ |post| post.popular? }.first
      return if swap_cand.nil?
      old_index, new_index = posts.index(cand), posts.index(swap_cand)
      posts[old_index], posts[new_index] = posts[new_index], posts[old_index]
    end
  end

end
