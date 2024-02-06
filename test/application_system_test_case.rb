require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400],
  # options: {
  #   browser: :remote,
  #   url: "http://host.docker.internal:9515"
  # }

  Capybara.register_driver(:remote_chrome) do |app|
    # Using docker, we need to define the port to run the application
    Capybara.app_host = "http://localhost:3001"
    Capybara.server_port = "3001"
    Capybara.server_host = '0.0.0.0'
    Capybara.server = :puma

    logger = Selenium::WebDriver.logger
    logger.level = :warn
    options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument('--headless') if ENV['HEADLESS']
    options.add_argument('--window-size=1920,1080')
    Capybara::Selenium::Driver.new(app, browser: :remote, url: 'http://host.docker.internal:9515/', options:)
  end

  Capybara.register_driver(:remote_firefox) do |app|
    # Using docker, we need to define the port to run the application
    Capybara.app_host = "http://localhost:3001"
    Capybara.server_port = "3001"
    Capybara.server_host = '0.0.0.0'
    Capybara.server = :puma

    logger = Selenium::WebDriver.logger
    logger.level = :warn
    options = Selenium::WebDriver::Firefox::Options.new
    # options.add_argument('--headless') if ENV['HEADLESS']
    options.add_argument('--window-size=1920,1080')
    Capybara::Selenium::Driver.new(app, browser: :remote, url: 'http://host.docker.internal:9515/', options:)
  end

  if ENV['DOCKER_TEST']
    if ENV['BROWSER'] == 'firefox'
      driven_by :remote_firefox
    else
      driven_by :remote_chrome
    end
  else
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end

end
