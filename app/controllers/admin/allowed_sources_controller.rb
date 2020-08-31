class Admin::AllowedSourcesController < Admin::Base
  def index
    @allowed_sources = AllowedSource.where(namespace: "staff")
      .order(:octet1, :octet2, :octet3, :octet4)
      @new_allowed_source = AllowedSource.new
  end

  def delete
    if Admin::AllowedSourceDeleter.new.delete(params[:form])
      flash.notice = "許可IPアドレスを削除しました。"
    end
    redirect_to action: "index"
  end
end
