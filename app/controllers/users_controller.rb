class UsersController < ApplicationController
  before_filter :check_admin

  def index
    authorizations = Authorization.where(:assembly_uuid => @assembly.uuid)
    @users = authorizations.collect { |a| User.find(a.user_id) }
  end
end
