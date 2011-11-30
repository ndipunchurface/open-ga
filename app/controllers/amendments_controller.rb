class AmendmentsController < ApplicationController
  before_filter :authorize, :only => [:edit, :update, :destroy]

  def index
    @amendments = Amendment.all
  end

  def show
    @amendment = Amendment.find(params[:id])
  end

  def new
    @amendment = Amendment.new
  end

  def create
    @amendment = Amendment.new(params[:amendment])

    if @amendment.save
      flash[:success] = "Amendment submitted successfully"
      redirect_to assembly_proposal_amendment_url(@assembly,@proposal, @amendment)
    else
      render :new
    end
  end

  def edit
      @amendment = Amendment.find(params[:id])
  end

  def update
    @amendment = Amendment.find(params[:id])

    @amendment.title = params[:amendment][:title]
    @amendment.body = params[:amendment][:body]

    if @amendment.save
      flash[:success] = "Amendment updated successfully."
      redirect_to assembly_proposal_amendment_url(@assembly,@proposal,@amendment)
    else
      render :new
    end
  end

  def destroy
    Amendment.find(params[:id]).destroy
  end

  private

  def authorize
    unless current_user == @amendment.user_id
      not_authorized_redirect
    end
  end

  def not_authorized_redirect
    flash[:error] = "You are not authorized to perform this action"
    redirect_to assembly_proposal_amendment_url(@assembly,@proposal,@amendment)
  end
end
