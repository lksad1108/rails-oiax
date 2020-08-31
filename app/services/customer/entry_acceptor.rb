class Customer::EntryAcceptor
  def initialize(customer)
    @customer = customer
  end

  def accept(program)
    # if max = program.max_number_of_participants
    #   if program.entries.where(canceled: false).count < max
    #     program.entries.create!(customer: current_customer)
    #     return :accepted
    #   else
    #     return :full
    #   end
    # else
    #   program.entries.create!(customer: current_customer)
    # endif max = program.max_number_of_participants
    #   if program.entries.where(canceled: false).count < max
    #     program.entries.create!(customer: current_customer)
    #     return :accepted
    #   else
    #     return :full
    #   end
    # else
    #   program.entries.create!(customer: current_customer)
    # end
    raise if Time.current < program.application_start_time
    return :closed if Time.current >= program.application_end_time
    ActiveRecord::Base.transaction do
      program.lock!
      # if max = program.max_number_of_participants
      if program.entries.where(customer_id: @customer.id).exists?
        return :accepted
      elsif max = program.max_number_of_participants
        if program.entries.where(canceled: false).count < max
          program.entries.create!(customer: current_customer)
          return :accepted
        else
          return :full
        end
      else
        program.entries.create!(customer: current_customer)
      end
    end
  end
end
