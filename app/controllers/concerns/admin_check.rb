module AdminCheck extend ActiveSupport::Concern
  def admin?
    redirect_to root_path, notice: 'Permission denied!' unless current_user.admin?
  end
end