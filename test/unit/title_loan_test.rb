require 'test_helper'

class TitleLoanTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TitleLoan.new.valid?
  end
end
