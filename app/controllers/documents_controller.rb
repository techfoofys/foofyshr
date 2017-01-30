class DocumentsController < InheritedResources::Base

  before_action :authenticate_user!

  before_action :authorize_d_hr, only: [:index , :show ,:new , :edit , :create , :update , :destroy]
  
  private

    def document_params
      params.require(:document).permit(:user_id, :title ,:doc_image)
    end
end
