# Recreation Booking

Want to look for accoumadation in forest recreation areas immediately? Use Recreation Booking!

## Requirement
- ruby 2.6+
- bundler 2

## How to setup

run `bundle install` and `rackup` in the repository directory.

```bash
bundle install
mv config.yml.example config.yml # update config in config.yml
bundle exec rackup
```

## How to use

Currently you can search accoumadations in this area:
- Tai Ping Shan(太平山)

### Tai Ping Shan

|name/attribute|description|
|----|-----------|
|Area Name|Tai Ping Shan|
|url|`/calendar/taipingshan`|
|params| village(required), room_type_id(required)|
|example|`calendars/taipingshan?village=01&room_type_id=10`|
