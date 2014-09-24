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
    candidates = posts.select { |post| post.score > 0 }
    avg_score = candidates.reduce(0) { |total, post| total + post.score } / candidates.length
    posts.map { |post| post.popular = true if post.score > avg_score }
  end

  def swap_post(swap, posts)
    cand = posts.slice(swap, posts.length).reject { |post| post.popular? }.first
    throw :done if cand.nil?
    cand_index = posts.index(cand)
    posts[swap], posts[cand_index] = posts[cand_index], posts[swap]
  end

  def set_row(posts, index, toggler)
    row = posts[index..index+2]
    throw :done if row[1].nil? || row[2].nil?
    if row[0].popular? && row[1].popular?
      index += 2
      swap = toggler ? posts.index(row[1]) : posts.index(row[0])
      toggler = !toggler
    elsif row[0].popular? || row[1].popular?
      index += 2
      swap = nil
    elsif row[2].popular?
      index += 3
      swap = posts.index(row[2])
    else
      index += 3
      swap = nil
    end
    [swap, index, toggler]
  end

  # ensure that the popular posts are ordered according to created_at
  def shift_posts(posts)
    swaps = { }
    popular_posts = posts.select { |post| post.popular? }
    popular_posts.each do |post|
      cand = popular_posts.select { |p|
        post.created_at < p.created_at &&
        posts.index(post) < posts.index(p) &&
        !swaps.has_key?(posts.index(p))
      }.first
      swaps[posts.index(cand)] = posts.index(post) if cand
    end
    swaps.each do |nw, old|
      posts[nw], posts[old] = posts[old], posts[nw]
    end
  end

  def gridify(posts)
    catch :done do
      swap, index, toggler = [nil, 0, false]
      while true do
        swap_post(swap, posts) if swap
        swap, index, toggler = set_row(posts, index, toggler)
      end
    end
    shift_posts(posts)
  end

end
