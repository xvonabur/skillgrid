Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.folderList'] = 2

  # Suppress "open with" dialog
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'application/zip'
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

# switch the default Capybara driver from selenium
Capybara.javascript_driver = :webkit
Capybara.default_max_wait_time = 10

