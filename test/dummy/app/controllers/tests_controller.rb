class TestsController < ApplicationController
  def test
    @current_user = current_user
  end

  def delete_user
    current_user.delete_user_data do
      puts '------------------------------'
      puts '--      THIS IS A BLOCK     --'
      puts '------------------------------'
    end

    redirect_to '/'
  end
end