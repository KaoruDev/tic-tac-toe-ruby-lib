# Tic Tac Toe Lib

Play tic tac toe!

## Dependencies

- Ruby 2.5.1 - See https://github.com/rbenv/rbenv
- Bundler - `gem install bundler`
- sqlite3 - `brew install sqlite3`

OR

- Docker https://docs.docker.com/docker-for-mac/jj

## Documentation

**Method Patterns**

Instead of raising exceptions, `Game` methods will return a `String` describing the error it encountered.

### Using lib

```ruby
require_relative "lib/models/game"
```


### Playing a game

1. Start a game: `Game.new(<player_one_id>, <player_two_id>)`
- `player_one_id` & `player_two_id` must be not null and cannot be the same
  value. In other words, the same player may not play themselves.

```ruby
game = Game.new(1, 2)
error = game.start
```

Returns error when:
- game cannot be started. Error will describe the reason why.

2. Place a mark:
```ruby
error = game.place(<coordinate>, <player_id>)
```

Returns error when:
- A player tries to go out of turn.
- A player tries to go on to a `coordinate` already taken.
- Player assigned to `player_one_id` must go first. I.e. `Game.new(3, 2)`, player with id `3` must go first.

3. Find game state
```ruby
winner_id = game.state
```

Returns a hash with information about the state of the game.
- `:winner` - contains the `id` of the player, `nil` if there is none.
- `:done` - `true` if all coordinates have been filled or a winner has been declared.
- `:tied` - `true` if the game ended in a tie.


### Recover game
```ruby
game_id = game.id
game = nil
game = Game.find(game_id)
```

### Player's score
```ruby
Game.score_of(1) # => integer
```

Finds a player's score by player's id.


## Run Example

**On your machine**

```ruby
bundle install
bin/example
```

**Using Docker**

```
docker build -t hummingbird-tic-tac-toe-example .
docker run --rm -it hummingbird-tic-tac-toe-example
```


## How to Run Tests

**On Your machine**
```
bundle install
bundle exec rspec
```

**Using Docker**

```
docker build -t hummingbird-tic-tac-toe-tests -f test.dockerfile .
docker run --rm hummingbird-tic-tac-toe-tests
```

