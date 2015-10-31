require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "5d92b67c1571964b198a4cb03ec1ceabe6a2830bb25e2fe5d00a19fb79e16369"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')

  # Override the .url method...
  define_url do |app, job, opts|
    thumb = Thumb.find_by_job(job.signature)
    # If (fetch 'some_uid' then resize) has been stored already,
    # give the datastore's remote url ...
    if thumb
      app.datastore.url_for(thumb.uid)
      # ...otherwise give the local Dragonfly server url
    else
      app.server.url_for(job)
    end
  end

  # Before serving from the local Dragonfly server...
  before_serve do |job, env|
    # store the thumbnail in the datastore
    uid = job.store

    # keep track of its uid so next time we can serve directly from the datastore
    Thumb.create!(
        :uid => uid,
        :job => job.signature   # 'BAhbBls...' - holds all the job info
    )                           # e.g. fetch 'some_uid' then resize
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end


