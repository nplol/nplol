class User

  ROLES = %w(nplol regular)

  attr_accessor :name, :avatar

  def initialize(options = {})
    @name = options[:name]
    @avatar = options[:image]
    @role = 'regular'
  end

  def authorize
    @role = 'nplol'
  end

  def nplol?
    @role == 'nplol'
  end

end
