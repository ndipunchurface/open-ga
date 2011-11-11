module Services::ApplicationHelper
  def post_success
    {:status => "success", :response_code => 0}.to_json
  end

  def invalid_action
    {:status => "error", :response_code => 1, :reason => "This action is invalid"}.to_json
  end

  def invalid_token
    {:status => "error", :response_code => 2, :reason => "The provided token is invalid"}.to_json
  end

  def no_records
    {:status => "error", :response_code => 3, :reason => "No Records Found"}.to_json
  end

  def no_record
    {:status => "error", :response_code => 4, :reason => "Record not found"}.to_json
  end

  def post_fail_validation(errors)
    {:status => "error", :response_code => 5, :reasons => errors.to_json}.to_json
  end

  def post_fail_unknown
    {:status => "error", :response_code => 6, :reason => "An unknown error has occured" }.to_json
  end
end
