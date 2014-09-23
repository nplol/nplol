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
      swap = toggler ? posts.index(row[0]) : posts.index(row[1])
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

  def gridify(posts)
    catch :done do
      swap, index, toggler = [nil, 0, false]
      while true do
        swap_post(swap, posts) if swap
        swap, index, toggler = set_row(posts, index, toggler)
      end
    end
  end

end
