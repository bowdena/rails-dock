This is a simple rails application that is designed to test out a few things.

The main entry point is for testing:
```bash
> $ rails test
```
Capybara testing
```bash
> $ rails test:system
```


## Build
```bash
bowdena@zn42957 ~/code/personal
> $ gem install rails -v 7.1.3
bowdena@zn42957 ~/code/personal
# Required as I'm using libpq rather than the postgres https://gist.github.com/tomholford/f38b85e2f06b3ddb9b4593e841c77c9e                                                                                                                   > $ export CONFIGURE_ARGS="with-pg-include=/opt/homebrew/Cellar/libpq/16.1_1/bin/pg_config"
> $ rails _7.1.3_ new photo_example --css=tailwind --javascript=esbuild --asset-pipeline=propshaft --database=postgresql
> $ cd photo_example
```
### Add in action text
```bash
# https://guides.rubyonrails.org/action_text_overview.html
> $ rails action_text:install
> $ bundle install
> $ rails db:migrate
```
### Add in the Post and Comment models

```
> $ rails g scaffold Post title:string description:rich_text
> $ rails g scaffold Comment content:rich_text post:references
```



### Add in the admistrative gem from thoughtbot

```
# Add the administrate gem
gem "administrate", git: 'https://github.com/thoughtbot/administrate.git'
....
> $ rails generate administrate:install
# does not work with action text
# Endpoint is http://localhost:3000/admin/
```
