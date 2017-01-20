module HrHelper
  def get_status(user)
    temp = UserProfile.where(user_id: user)
    if temp.empty?
      "NA"
    else
      temp.first.status.title
    end

  end
end
