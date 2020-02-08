require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative('../member')

class TestMember < Minitest::Test
  def setup()
    options = {
      "id" => 1,
      "first_name" => "Bill",
      "last_name" => "Billerson",
      "goal" => "Get stronger"
    }
    @member = Member.new(options)
  end

  def test_full_name()
    full_name = @member.full_name()
    assert_equal("Bill Billerson", full_name)
  end

  def test_formal_name()
    formal_name = @member.formal_name()
    assert_equal("B. Billerson", formal_name)
  end
end
