# NEXT Rails - WIP

`next_rails` is a gem that will help you upgrade your rails applications to the `next` rails version.

## Usage

The first thing you want to do is setup `dual bootin`. This will allow you to `boot` your application with two versions of Rails, the current one and the one you are trying to upgrade to.

## Init

```shell
$ next init --rails-version 6.0.0
```

This command will do a a few things:

1. It will create a `Gemfile.next` symlink. This `Gemfile` will be used when you want to run your application with the new Rails version.
2. It will modify your `Gemfile` to add `magic` :crystal_ball: that the `next` tool will use

Now to execute commands in the context of your new Rails version all you have to do is prepend the `next` tool to any of your normal commands.

**Example:**

 `next install` this will try to `bundle istall` with your new Rails version

 `next rspec spec/...` check if your tests pass with your new Rails version.

 ```shell
$ next --help
Commands:
  next compatibility   # Check if your current "bundle" is compatible with a specific version of Ruby on Rails
  next init            # Configure dual booting
  next outdated        # Check which gems are outdated in your "bundle"
  next help [COMMAND]  # Describe available commands or one specific command
```

