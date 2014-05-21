class PostPolicy < Struct.new(:user, :post)

  def manage?
    user.nplol?
  end

end
