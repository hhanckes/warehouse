require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "new_order" do
    mail = Notification.new_order
    assert_equal "New order", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "funds_received" do
    mail = Notification.funds_received
    assert_equal "Funds received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
