class Customer::EntriesController < Customer::Base
  def create
    program = Program.published/find(params[:program_id])
    # program.entries.create!(customer: current_customer)
    # flash.notice = "プログラムに申し込みました。"
  #   if max = program.max_number_of_participants
  #     if program.entries.where(canceled: false).count < max
  #       program.entries.create!(customer: current_customer)
  #       flash.notice = "プログラムに申し込みました。"
  #     else
  #       flash.alert = "プログラムへの申込者数が上限に達しました。"
  #     end
  #   else
  #     program.entries.create!(customer: current_customer)
  #     flash.notice = "プログラムに申し込みました。"
  #   end
  #   redirect_to [ :customer, program]
  # end
  case Customer::EntryAcceptor.new(current_customer).accept(program)
    when :accepted
      flash.notice = "プログラムに申し込みました。"
    when :full
      flash.alert = "プログラムへの申込者数が上限に達しました。"
    when :closed
      flash.alert = "プログラムへの申込期間が終了しました。"
    end
    redirect_to [ :customer, program]
  end

  def cancel
    program = Program.published.find(params[:program_id])
    if program.application_end_time.try(:<, Time.current)
      flash.alert = "プログラムへの申込みをキャンセルできません（受付期間終了）。"
    else
      entry = program.entries.find_by!(customer_id: current_customer_id)
      entry.update_column(:canceled, true)
      flash.notice = "プログラムへの申込みをキャンセルしました。"
    end
    redirect_to [ :customer, program ]
  end
end
