# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Precompile FontAwesome fonts
Rails.application.config.assets.precompile <<
    %r(font-awesome/fonts/[\w-]+\.(?:eot|svg|ttf|woff|woff2|otf?)$)

# Precompile Bootstrap fonts
Rails.application.config.assets.precompile <<
    %r(bootstrap-sass-official/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)

Rails.application.config.assets.precompile += %w( admin-lte/dist/img/boxed-bg.jpg )

# Precompile Adminlte fonts
Rails.application.config.assets.precompile << %r(EOT/.*\.eot$)
Rails.application.config.assets.precompile << %r(OTF/.*\.otf$)
Rails.application.config.assets.precompile << %r(TTF/.*\.ttf$)
Rails.application.config.assets.precompile << %r(WOFF/.*\.woff$)

# Minimum Sass number precision required by bootstrap-sass
::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max

Rails.application.config.assets.precompile += %w(iCheck/skins/square/blue.png iCheck/skins/square/blue@2x.png)


# Add all images from vendor/assets/images
Dir.glob("#{Rails.root}/vendor/assets/images/**/").each do |path|
  Rails.application.config.assets.paths << path
end