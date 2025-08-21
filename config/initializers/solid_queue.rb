SolidQueue.configure do |config|
  # Use the primary database instead of a separate queue database
  config.database_connection = ActiveRecord::Base.connection
end