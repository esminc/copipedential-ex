source :rubygems

gem 'rails', '~> 3.2.1'
gem 'rack', '~>1.4.1'
gem 'pg'

gem 'foreman'
gem 'jquery-rails'
gem 'haml-rails'
gem 'coffee-filter'

gem 'responders'
gem 'omniauth-github'
gem 'hubruby'
gem 'kaminari'
gem 'tapp'
gem 'bootstrap-sass', git: 'git://github.com/thomas-mcdonald/bootstrap-sass.git'
gem 'twitter_bootstrap_form_for', git: 'git://github.com/stouset/twitter_bootstrap_form_for.git', branch: 'bootstrap-2.0'
gem 'gyomu_ruby', git: 'git://github.com/esminc/gyomu_ruby.git'

gem 'thin', group: :production
gem 'redcarpet'

group :assets do
  gem 'sass-rails',   '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'i18n_generators'

  group :test do
    gem 'rspec-rails'
    gem 'fabrication'
    gem 'pry-rails'
    gem 'tapp'
    gem 'awesome_print'
    gem 'auto_truncated_logger'

    gem 'ruby-debug19'
    gem 'ruby-debug-base19x', '>= 0.11.30.pre10'
    gem 'linecache19', git: 'https://github.com/mark-moseley/linecache.git', ref: '869c6a65155068415925067e480741bd0a71527e'
  end
end

group :test do
  gem 'cucumber-rails'
end
