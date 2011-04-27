require 'test_helper'

class TitleLoansControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => TitleLoan.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    TitleLoan.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    TitleLoan.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to title_loan_url(assigns(:title_loan))
  end

  def test_edit
    get :edit, :id => TitleLoan.first
    assert_template 'edit'
  end

  def test_update_invalid
    TitleLoan.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TitleLoan.first
    assert_template 'edit'
  end

  def test_update_valid
    TitleLoan.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TitleLoan.first
    assert_redirected_to title_loan_url(assigns(:title_loan))
  end

  def test_destroy
    title_loan = TitleLoan.first
    delete :destroy, :id => title_loan
    assert_redirected_to title_loans_url
    assert !TitleLoan.exists?(title_loan.id)
  end
end
