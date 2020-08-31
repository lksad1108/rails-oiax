class Customer::Authenticator
  def initialize(customer)
    @customer = customer
  end

  def authenticate(raw_password)
    @customer &&
      @customer.hashed_password &&
        Bcrypt::Password.new(@customer.hashed_password) == raw_password
  end
end
