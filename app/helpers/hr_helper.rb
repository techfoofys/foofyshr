module HrHelper
  def get_status(user)
    UserProfile.where(user_id: user).first.status.title
  end
end
