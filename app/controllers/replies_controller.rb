class RepliesController < ApplicationController
  def index
    @replies = Reply.all
  end

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.new(params[:reply])

    if @reply.save
      flash[:success] = "Reply submitted successfully"
      if params[:amendment_id].nil?
        redirect_to assembly_proposal_url(@assembly.id,@proposal.id)
      else
        redirect_to assembly_proposal_amendment_url(@assembly,@proposal.id,@amendment.id)
      end
    else
      render :new
    end
  end
end
