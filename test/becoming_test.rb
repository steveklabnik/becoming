require 'test_helper'

require 'becoming'

User = Struct.new(:first_name, :last_name) do
  include Becoming
end

module FullNamed
  def full_name
    "#{first_name} #{last_name}"
  end
end

module Nicknamed
  def nickname
    "#{first_name} \"SKRILLEX\" #{last_name}"
  end
end

class BecomingTest < MiniTest::Unit::TestCase
  def test_becomings
    user = User.new("Steve", "Klabnik")
    user.becoming(FullNamed)
    user.becoming(Nicknamed)

    assert user.send(:respond_to_missing?, :full_name)
    assert_equal "Steve Klabnik", user.full_name
    assert user.send(:respond_to_missing?, :nickname)
    assert_equal 'Steve "SKRILLEX" Klabnik', user.nickname

    user.unbecoming(Nicknamed)

    assert !user.send(:respond_to_missing?, :nickname)
    assert_raises(NoMethodError) { user.nickname }

    assert user.send(:respond_to_missing?, :full_name)
  end
end
