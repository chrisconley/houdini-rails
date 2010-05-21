class Houdini::PostbacksController < ApplicationController
  def create
    subject_class = params[:subject_class].classify.constantize
    subject = subject_class.find(params[:subject_id])
    if subject.process_postback(params[:answer])
      render :json => {:success => true}
    else
      render :json => {:success => false}, :status => 422
    end
  end
end