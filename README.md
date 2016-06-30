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
resources= { 
  0 => { 'attribute' => 'test' }, 
  1 => { 'attribute' => 'cheese' } 
}

Model.update!(resources.keys, resources.values)
```

## YARDocs
You can view the activeupdate documentation in YARDoc format [here](http://www.rubydoc.info/gems/activeupdate).

## Versioning
http://semver.org

with inspiration courtesy of @danieljacobarcher
