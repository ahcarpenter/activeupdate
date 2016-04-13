# ActiveUpdate
## Installation
```
gem install activeupdate
```
currently, the following is also required to be bundled:
```ruby
gem 'arel', github: 'rails/arel', branch: 'master'
```
## Usage
```ruby
# Updating multiple records
resource_hash = { 
  '0' => { 'id' => '1', 'attribute' => 'test' }, 
  '1' => { 'id' => '2', 'attribute' => 'cheese' } 
}

Model.update!(resource_hash)
```

## YARDocs
You can view the activeupdate documentation in YARDoc format [here](http://www.rubydoc.info/gems/activeupdate/0.0.4).

## Versioning
http://semver.org

with inspiration courtesy of @danieljacobarcher
