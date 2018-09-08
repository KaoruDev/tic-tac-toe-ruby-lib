# Tic Tac Toe Lib

This is a generic library to

# Documentation

# Dependencies

- Ruby 2.5.1 - See https://github.com/rbenv/rbenv
- Bundler - `gem install bundler`
- sqlite3 - `brew install sqlite3`

# How to Run Tests

**On Your machine**
```
bundle install
bundle exec rspec
```

**Using Docker**

```
docker build -t hummingbird-tic-tac-toe -f test.dockerfile .
docker run --rm -it hummingbird-tic-tac-toe
```


# TODO
- Write API documentation
- Write dockerfile that runs exmaple.rb which starts a pry session with the lib loaded
