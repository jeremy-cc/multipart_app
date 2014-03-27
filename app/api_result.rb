#important that it's a hash so sinatra let's it through untouched
class ApiResult < Hash

  attr_accessor :plain_response

  def plain_response= bool
    @plain_response = bool
  end

  def plain_response?
    @plain_response
  end

  def data
    self[:data]
  end

  def self.plain(data)
    api_result = ApiResult[:data => data]
    api_result.plain_response = true
    api_result
  end

  def self.success(data = nil)
    ApiResult[:status => 'success', 'data' => data || {}]
  end

  def self.failure(reason = nil, error_code = nil)
    ApiResult[:status => 'failed', 'reason' => (reason || 'No reason given'), 'error_code' => error_code]
  end

  def self.error(error = nil)
    error = error.message if error.respond_to?(:message)
    ApiResult[:status => 'error', 'message' => error || 'No message supplied']
  end

  def self.service_unavailable
    ApiResult[:status => 'timed-out', 'data' => {}]
  end

  def self.assert_successful(result, error_string = 'A call to a remote service failed')
    return if result[:status] == 'success'
    raise "#{error_string} [#{result['reason']}]" if result[:status] =='failed'
    raise "#{error_string} [#{result['message']}]" if result[:status] =='error'
  end
end