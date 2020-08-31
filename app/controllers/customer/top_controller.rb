class Customer::TopController < Customer::Base
  skip_before_action :authorize

  def index
    # render action: "index"
    if current_customer
      render action: "dashboard"
    else
      render action: "index"
    end
  end
end
