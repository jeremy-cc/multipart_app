class Adaptor < Sinatra::Base
  post '/new_download_received' do
    begin
      require 'pp'

      pp request.env
      pp request.env["rack.request.form_hash"]
      pp request.env["rack.input"].inspect

      uploaded_file = params['uploadedfile']
      raise 'No upload file specified' if !uploaded_file
      tempfile = uploaded_file[:tempfile]

      @handler.handle_new_download_received(uploaded_file[:filename], tempfile, params[:async] || 'true')
    rescue StandardError => e
      [:status=>'failed', 'message'=>e.message]
    ensure
      if tempfile
        tempfile.close
        tempfile.delete
      end
    end
  end

end