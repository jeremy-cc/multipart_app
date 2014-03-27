# defines the initial url maps assigned to the various HTTP connectors.  Note that in torquebox these are prepended
# with the context field set for the application in config/torquebox.yml
urlmap = {
  "/downloads" => Adaptor.new,
}

run Rack::URLMap.new(urlmap)