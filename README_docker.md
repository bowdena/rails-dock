Installing Docker for development,
based on https://www.driftingruby.com/episodes/developing-in-docker?query=docker

Update the .dockerignore file and configure to ignore the Dockerfile.dev
```
Dockerfile.dev
```

Within the database.yml file, update the database connection:
```
url: <%= ENV.fetch("DATABASE_URL") {postgres://postgres:postgres@localhost/photo_example_development} %>
```

Update the Procfile.dev (called from bin/dev) to bind to all the addresses (as we're running in docker)
```
# From web: env RUBY_DEBUG_OPEN=true bin/rails server
# To:
web: env RUBY_DEBUG_OPEN=true bin/rails server -b 0.0.0.0
```


```
docker-compose up
docker-compose down
docker container ls
docker image ls
> $ docker image rm photo_example-app
# rebuild from scratch
> $ docker-compose --no-cache
```
18:58

```
> $ docker-compose up --detach
> $ docker-compose ls
# run the logs in the console
> $ docker-compose logs -f
# join the container
> $ docker-compose run app bash
# restart the container
> $ docker-compose restart

# Testing
# outside of the container
> $ bundle add faker
> $ touch tmp/restart.txt
> $ docker-compose logs -f
app-1       | 09:26:37 web.1  | * Restarting...
app-1       | 09:26:37 web.1  | /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/definition.rb:540:in `materialize': Could not find faker-3.2.3 in locally installed gems (Bundler::GemNotFound)
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/definition.rb:200:in `specs'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/definition.rb:266:in `specs_for'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/runtime.rb:18:in `setup'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler.rb:162:in `setup'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/setup.rb:23:in `block in <top (required)>'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/ui/shell.rb:159:in `with_level'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/ui/shell.rb:111:in `silence'
app-1       | 09:26:37 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/setup.rb:23:in `<top (required)>'
app-1       | 09:26:37 web.1  |         from <internal:/usr/local/lib/ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:85:in `require'
app-1       | 09:26:37 web.1  |         from <internal:/usr/local/lib/ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:85:in `require'
...
> $ docker-compose run app bundle                                                                                                                                                                                                                                                                                     [±main ●●]
WARN[0000] The "REDIS_URL" variable is not set. Defaulting to a blank string.
[+] Creating 2/0
 ✔ Container photo_example-postgres-1  Running                                                                                                                                                                                                                                                                              0.0s
 ✔ Container photo_example-redis-1     Running                                                                                                                                                                                                                                                                              0.0s
Fetching gem metadata from https://rubygems.org/...
Installing faker 3.2.3
Bundle complete! 18 Gemfile dependencies, 92 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
> $ docker-compose logs
...
app-1       | 09:30:25 web.1  | /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/definition.rb:540:in `materialize': Could not find faker-3.2.3 in locally installed gems (Bundler::GemNotFound)
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/definition.rb:200:in `specs'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/definition.rb:266:in `specs_for'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/runtime.rb:18:in `setup'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler.rb:162:in `setup'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/setup.rb:23:in `block in <tπop (required)>'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/ui/shell.rb:159:in `with_level'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/ui/shell.rb:111:in `silence'
app-1       | 09:30:25 web.1  |         from /usr/local/bundle/gems/bundler-2.4.15/lib/bundler/setup.rb:23:in `<top (required)>'
app-1       | 09:30:25 web.1  |         from <internal:/usr/local/lib/ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:85:in `require'
app-1       | 09:30:25 web.1  |         from <internal:/usr/local/lib/ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:85:in `require'
app-1       | 09:30:25 web.1  |         from /app/config/boot.rb:3:in `<top (required)>'
app-1       | 09:30:25 web.1  |         from bin/rails:3:in `require_relative'
app-1       | 09:30:25 web.1  |         from bin/rails:3:in `<main>'
app-1       | 09:30:25 js.1   | $ esbuild app/javascript/*.* --bundle --sourcemap --format=esm --outdir=app/assets/builds --public-path=/assets --watch
app-1       | 09:30:25 css.1  | $ tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify --watch
app-1       | 09:30:25 js.1   | [watch] build finished, watching for changes...
app-1       | 09:30:26 css.1  |
app-1       | 09:30:26 css.1  | Rebuilding...
...
# doesn't work because the container needs to be rebuilt
> $ docker-compose up -d --build
# shell into the running app rather than a new container with docker-compose run
> $ docker-compose exec app bash

# shortcut
> $ source .docker/.coderc
> $ dcu # docker-compose up, if you ctrl+c, this will background - > $ docker container ls
# Close and remove the docker container
> $ dcd
# build the container using a cached docker container
> $ dcb
# force a rebuild of the container
> $ dcbc
# create new container
> $ dcr
# join th existing running app
> $ dce bash
root@92bdcd2300a6:/app# bundle add stripe
# end of the day, you can dcs (stop)
# start of the next day, you can dcs (start)


