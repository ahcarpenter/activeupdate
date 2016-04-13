# ActiveUpdate
## Installation
```activeupdate``` can be installed via the execution of the following command:
```
gem install activeupdate
```
currently, the following is also required to be bundled:
```ruby
gem 'arel', github: 'rails/arel', branch: 'master'
```
## Usage
```ruby
resource_hash = { 
  '0' => { 'id' => '34', 'attr_name' => 'y' }, 
  '1' => { 'id' => '29', 'attr_name' => 'z' } 
}

Model.update!(resource_hash)
```

## Versioning
http://semver.org
