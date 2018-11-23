class TestsController < ApplicationController
  def test
    @current_user = current_user
  end
end