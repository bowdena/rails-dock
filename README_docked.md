# Based on https://www.driftingruby.com/episodes/rails-docked?query=docked

# Install Docker (out of scope of this document)

# Go to https://github.com/rails/docked
```bash
# Build the ruby-bundle-docker volume for caching
> $ docker volume create ruby-bundle-cache
ruby-bundle-cache
```

# Load the aliases from the .dockedrc file
```bash
> $ source .dockedrc
```

### Problem 1
## Problem with postgres and docked.
# documented here: https://github.com/rails/docked/issues/28

# build custom docker container
```bash
> $ docker build -t my-docked-override -f Dockerfile.override .
```
# update the .dockrc file
```bash
> $ my-docked-override
> $ dbundle
```

### Problem 2
The database on the docker container cannot connect to the local host db.
```bash
drails server
```
# Update the database.yml file
```yaml
default: &default
  ...
  host: <%= ENV['DATABASE_HOST'] || 'localhost' %>
  ...
```
Update the docked stanza to include the DATABASE_HOST environment variable
```bash
alias docked='docker run -e DATABASE_HOST=host.docker.internal --r....
```

### Problem 3
## npm complains
```
09:00:28 js.1   | Error:
09:00:28 js.1   | You installed esbuild for another platform than the one you're currently using.
09:00:28 js.1   | This won't work because esbuild is written with native code and needs to
09:00:28 js.1   | install a platform-specific binary executable.
```
THis is an issue with mac vs linux architecture.
The solution is to run
dyarn when using the docker container
and yarn to rebuild the assets when you're not.







