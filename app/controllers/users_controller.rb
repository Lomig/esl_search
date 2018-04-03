class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  def index
    # @users = User.all
    @user = policy_scope(User).order(created_at: :desc)
  end
  def show
    @message = Message.new
    @privatemessage = Privatemessage.new
  end

  def search
  end
  private
  def find_user
    @user = User.find(params[:id])
    authorize @user
  end
end
