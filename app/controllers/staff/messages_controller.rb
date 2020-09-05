class Staff::MessagesController < Staff::Base
  def index  
    @messages = Message.not_deleted.sorted.page(params[:page])
    if parmas[:tag_id]
      @messages = Message.joins(:message_tag_links)
        .where("message_tag_links.tag_id" => params[:tag_id])
        .tagged_as(params[:tag_id])
    end
  end 
  
  def inbound 
    @messages =  CustomerMessage.not_deleted.sorted.page(params[:page])
      .tagged_as(params[:tag_id])
    render action: "index"
  end
  
  def outbound 
    @messages = StaffMessage.not_deleted.sorted.page(params[:page])
  end 

  def deleted
    @messages = Message.deleted.sorted.page(params[:page])
      .tagged_as(params[:tag_id])
    render action: "index"
  end

  def show
    @message = Message.find(params[:id])
  end
  
  def destroy
    message = CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = "問い合わせを削除しました。"
    redirect_back(fallback_location: :staff_root)
  end
  
end
