class ReportsController < ApplicationController
  def index
    @reports = if containg_tags?
                 Profile.joins(:repositories)
                        .where('"repositories"."tags" LIKE ?', "%#{params[:tags]}%").group(:profile_id)
               else
                 Profile.all
               end

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def containg_tags?
    params[:tag].present?
  end
end
