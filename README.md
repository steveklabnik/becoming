# Becoming

Have you ever used delegation libraries, but found them a bit unsatisfactory?
Delegation is awesome, but many Ruby libraries love their metaprogramming, and
so they expect class names to match up. This often screws up delegation.

Becoming allows your objects to have 'becomings' that make them have extended
functionality. They still have the same class as they did before, but now
they're just... different.

## Installation

Add this line to your application's Gemfile:

    gem 'becoming'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install becoming

## Usage

For example, let's imagine you're writing a Rails form:

```ruby
# a model that looks like this
User = Struct.new(:first_name, :last_name)

# in the controller
@user = User.new("Steve", "Klabnik")

# in the view
<%= form_for @user do |f| %>
```

This does reflection on the class of the `@user`, generating HTML like this:

```html
<form action="/users/1">
```

This is mega awesome. But, let's say that we want to add some new presentation
methods on our `User`. So we make a class:

```ruby
class FullNameUser
  def initialize(user)
    @user = user
  end

  def full_name
    "#{@user.first_name} #{@user.last_name}"
  end

  def method_missing(m, *args, &blk)
    @user.send(m, *args, &blk)
  end
end
```

We update our controller to use this new object:

```ruby
user = User.new("Steve", "Klabnik")
@user = FullNameUser.new(user)
```

Now, our form... does the wrong thing:

```html
<form action="/full_name_users/1">
```

Drat! So what do we do?

Answer: make your object have a becoming:

```
# in the model
User = Struct.new(:first_name, :last_name) do
  include Becoming
end

# your 'decorator'
module FullNamed
  def full_name
    "#{first_name} #{last_name}"
  end
end

# in the controller
@user = User.new("Steve", "Klabnik")
@user.becoming(FullNamed)
```

Now, your form will generate the same HTML as before, and everything is
just peachy.

### How does it work?

Magic.

### Is it any good?

Yes.

### What's the catch?

You can only use this with Ruby 2.0, sorry. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

Shout-outs go to Avdi Grimm, Gilles Deleuze, and Felix Guattari. Without them,
this gem wouldn't exist.
