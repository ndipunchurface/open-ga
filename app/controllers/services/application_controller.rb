class Services::ApplicationController < ApplicationController
  layout nil
  
  include Services::ApplicationHelper

  def index
    @records = model.all
    unless @records.empty?
      render :json => @records.to_json
    else
      render :json => no_records
    end
  end

  def show
    @record = model.find(params[:id])
    render :json => @record.to_json

  rescue ActiveRecord::RecordNotFound
    render :json => no_record
  end

#  def new
#    render :json => invalid_action
#  end
#
#  def create
#    @record = model.new(params)
#    if @record.valid?
#      if @record.save
#        render :json => post_success
#      else
#        render :json => post_fail_unknown
#      end
#    else
#      render :json => post_fail_validation(@record.errors.messages)
#    end
#  end
#
#  def edit
#    render :json => invalid_action
#  end
#
#  def update
#    @record = model.find(params[:id])
#    unless @record.nil?
#      @record.body = params[:body]
#
#      if @record.valid? && @record.save
#        render :json =>  post_success
#
#      elsif !@record.valid?
#        render :json => post_fail_validation(@record.errors.messages)
#
#      else
#        render :json => post_fail_unknown
#      end
#    else
#      render :json => no_record
#    end
#  end
#
#  def destroy
#    @record = model.find(params[:id])
#
#    if @record.destroy
#      render :json => post_success
#    else
#      render :json => post_fail_unknown
#    end
#
#  rescue ActiveRecord::RecordNotFound
#    render :json => no_record
#  end

  private

  def model
    self.class.to_s.gsub(/Services::([a-zA-Z]+)Controller/,'\1').singularize.constantize
  end
end
