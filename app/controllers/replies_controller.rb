class RepliesController < ApplicationController
  respond_to :html, :json

  def index
    @replies = Reply.all

    respond_to do |format|
      format.html
      format.json { render :text => @replies.to_json }
    end
  end

  def new
    @reply = Reply.new

    respond_to do |format|
      format.html
      format.json { render :text => @reply.to_json }
    end
  end

  def create
    @reply = Reply.new(params[:reply])

    if @reply.save
      flash[:success] = t('replies.create.success')

      respond_to do |format|
        format.html do
          if params[:amendment_id].nil?
            redirect_to assembly_proposal_url(@assembly.id,@proposal.id)
          else
            redirect_to assembly_proposal_amendment_url(@assembly,@proposal.id,@amendment.id)
          end
        end
        format.json { render :text => @reply.to_json }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render :text => @reply.to_json }
      end
    end
  end
end
