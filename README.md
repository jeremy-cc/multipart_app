multipart_app
=============

TorqueBox 3.0.2 multipart file upload bug demonstrator

Demonstrates issues with multipart file upload in TorqueBox 3.0.2 and 3.1.0 while TorqueBox 3.0.1 functions fine.

Test procedure:

    1. Download and install TorqueBox 3.0.2 or TorqueBox 3.1.0
    2. cd multipart_app
    3. bundle install
    4. torquebox deploy .
    5. curl -i -v -s -F uploadedfile='test.txt' http://{torqueboxhost}:{port}/multipart/downloads/new_download_received

# Testing under TorqueBox 3.0.2 or TorqueBox 3.1.0

## Expected Result

TorqueBox log should show:

    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,674 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.query_string"=>"async=false",
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,676 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.query_hash"=>{"async"=>"false"},
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,677 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.form_input"=>#<TorqueBox::RackChannel:0xfb8>,
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,679 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.form_hash"=>
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,680 INFO  [stdout] (http-/192.168.10.10:38080-1)   {"uploadedfile"=>
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,681 INFO  [stdout] (http-/192.168.10.10:38080-1)     {:filename=>"test.txt",
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,681 INFO  [stdout] (http-/192.168.10.10:38080-1)      :type=>"text/plain",
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,681 INFO  [stdout] (http-/192.168.10.10:38080-1)      :name=>"uploadedfile",
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,682 INFO  [stdout] (http-/192.168.10.10:38080-1)      :tempfile=>#<Tempfile:/tmp/RackMultipart20140327-13217-nb37x6>,
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,684 INFO  [stdout] (http-/192.168.10.10:38080-1)      :head=>
    Mar 27 10:23:56 v-1d35ac torquebox: 10:23:56,685 INFO  [stdout] (http-/192.168.10.10:38080-1)       "Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"test.txt\"\r\nContent-Type: text/plain\r\n"}}}

## Actual Result:

TorqueBox log shows:

    Mar 27 10:32:49 v-1d35ac torquebox: 10:32:49,446 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.query_string"=>"async=false",
    Mar 27 10:32:49 v-1d35ac torquebox: 10:32:49,448 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.query_hash"=>{"async"=>"false"},
    Mar 27 10:32:49 v-1d35ac torquebox: 10:32:49,449 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.form_input"=>#<TorqueBox::RackChannel:0xfb8>}

No multipart request is decoded.


# Testing under TorqueBox 3.0.0 or TorqueBox 3.0.1

TorqueBox log shows

    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,199 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.query_string"=>"async=false",
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,201 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.query_hash"=>{"async"=>"false"},
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,204 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.form_input"=>#<IO:0xfbc>,
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,207 INFO  [stdout] (http-/192.168.10.10:38080-1)  "rack.request.form_hash"=>
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,208 INFO  [stdout] (http-/192.168.10.10:38080-1)   {"uploadedfile"=>
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,209 INFO  [stdout] (http-/192.168.10.10:38080-1)     {:filename=>"test.txt",
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,210 INFO  [stdout] (http-/192.168.10.10:38080-1)      :type=>"text/plain",
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,210 INFO  [stdout] (http-/192.168.10.10:38080-1)      :name=>"uploadedfile",
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,212 INFO  [stdout] (http-/192.168.10.10:38080-1)      :tempfile=>#<Tempfile:/tmp/RackMultipart20140327-14066-ln4pn5>,
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,213 INFO  [stdout] (http-/192.168.10.10:38080-1)      :head=>
    Mar 27 10:40:23 v-1d35ac torquebox: 10:40:23,214 INFO  [stdout] (http-/192.168.10.10:38080-1)       "Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"test.txt\"\r\nContent-Type: text/plain\r\n"}}}

Diffs between TorqueBox 3.0.1 and TorqueBox 3.0.2

    https://github.com/torquebox/torquebox/compare/3.0.1...3.0.2

Most likely culprit is the change from using IO to RackChannel:

    https://github.com/torquebox/torquebox/commit/4af09da7a50fd4439143bd323aa135d6c49bc1cc#diff-a15cfe47437c25b76db0a1cdd4c28e79

