require 'api_result'

class ResponseFormatterMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      format_response(*@app.call(env))
    rescue ::Exception => e
      LOGGER.exception(e)
      format(500, {'Content-Type' => 'application/json'}, ApiResult.error(e))
    end
  end

  def format_response(status, headers, body)
    case status
      when 500..599
        format(status, headers, ApiResult.error(body))
      when 200
        if body.class == ApiResult
          if body.plain_response?
            format status, headers, body.data
          else
            format status, headers, body
          end
        else
          format(status, headers, ApiResult.failure('Response was not returned in an ApiResult object'))
        end
      else
        [status, headers, body]
    end
  end

  def format(status, headers, response)
    if headers["Content-Type"].include?('application/json')
      response = response.to_json
    end
    headers["Content-Length"] = response.length.to_s
    [status, headers, response]
  end
end
