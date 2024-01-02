ActiveModelSerializers.config.tap do |config|
    # Enable key_transform to automatically convert keys to camelCase
    config.key_transform = :camel_lower
  
    # Use the default adapter for rendering JSON
    config.adapter = :json_api
  end
  