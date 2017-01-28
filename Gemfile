source 'https://rubygems.org'

ruby '2.3.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'

gem "pg" #, git: "https://github.com/ged/ruby-pg"
# Use Puma as the app server
gem 'puma', group: :production

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen', '~> 3.0.5'
  gem 'ruby_parser', '>= 3.0.1'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'thin'
end

gem 'capistrano'
gem 'capistrano-rails'#, '1.1.3'
gem 'capistrano-rvm'
gem 'capistrano-bundler'#, '1.1.4'
gem 'capistrano3-puma'

gem 'cancancan'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'devise'
gem 'figaro'
gem 'font-awesome-rails', '4.6.3.0'
gem 'friendly_id', '~> 5.1.0'
gem 'kaminari'
gem 'meta-tags'
gem 'mimemagic'
gem 'mini_magick'
gem 'nested_form'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'redis-rails', '~> 5.0.1'
gem 'redis'
gem 'rolify'
gem 'truncate_html'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'formtastic'
gem 'foundation-rails'#, "6.3.0.0"
gem 'foundation-datepicker-rails'
gem 'haml'
gem "haml-rails"#, "~> 0.9"
gem 'jquery-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'foundation-icons-sass-rails'
gem 'coffee-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.5'

