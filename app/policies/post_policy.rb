class PostPolicy < Struct.new(:user, :post)

  def manage?
    !user.nil? && user.nplol?
  end

end
