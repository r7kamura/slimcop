# Slimcop

[![test](https://github.com/r7kamura/slimcop/actions/workflows/test.yml/badge.svg)](https://github.com/r7kamura/slimcop/actions/workflows/test.yml)

[RuboCop](https://github.com/rubocop/rubocop) runner for [Slim template](https://github.com/slim-template/slim).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slimcop'
```

And then execute:

```
bundle install
```

Or install it yourself as:

```
gem install slimcop
```

## Usage

Use `slimcop` executable to check offenses and auto-correct them.

```console
$ slimcop --help
Usage: slimcop [options] [file1, file2, ...]
    -a, --auto-correct               Auto-correct offenses.
```
