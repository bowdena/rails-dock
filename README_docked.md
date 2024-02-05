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



