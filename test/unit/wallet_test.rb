require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  def setup
    @wallet = Wallet.new
  end

  test "should recognize empty name" do
    @wallet.amount = 100
    @wallet.user = users(:user_with_wallet_1)
    assert_equal @wallet.valid?, false
  end

  test "should recognize invalid amount" do
    @wallet.attributes = { name: 'some_name', amount: 'blee' }
    @wallet.user = users(:user_with_wallet_1)
    assert_equal @wallet.valid?, false
  end

  test "wallet with expense should be valid" do
    wallet = Wallet.new(name: 'some_name', amount: 10, expenses_attributes: { 0=> { name: 'food', amount: 9, execution_date: '2012-11-12' } })
    wallet.user = users(:user_with_wallet_1)
    assert_equal wallet.valid?, true
  end

  test "should recognize invalid amount in expense" do
    wallet = Wallet.new(name: 'some_name', amount: '10', expenses_attributes: { 0=> { name: 'food', amount: 'ble', execution_date: '2012-11-12' } })
    wallet.user = users(:user_with_wallet_1)
    assert_equal wallet.valid?, false
  end

  test "should not save wallet without user" do
    assert_equal Wallet.new(name: 'some_name', amount: 15).valid?, false
  end

end
