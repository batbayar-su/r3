module ReasonDocumentationHelper
  def current_url(new_params)
    params.merge!(new_params)
    string = params.map{ |k,v| "#{k}=#{v}" }.join("&")
    request.env["REQUEST_URI"].split("?")[0] + "?" + string
  end
end
