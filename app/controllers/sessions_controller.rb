class SessionsController < ApplicationController
  before_action :current_user, only: [:show]
  # GET /sessions/1
  # GET /sessions/1.json
  def show; end

  # GET /sessions/new
  def new; end

  # POST /sessions
  # POST /sessions.json
  def create
    @user = User.find_by(name: params[:name])

    session[:current_user_id] = @user.id if @user

    respond_to do |format|
      if @user

        # format.html { redirect_to signed_in_path, notice: 'You have successfully logged in' }
        path_url = session[:previous_url] || user_path(@user)

        format.html { redirect_to path_url, notice: 'You have successfully logged in' }

        format.json { render @user, status: :'logged in' }
      else
        # format.html { redirect_to sign_in_url, notice: 'Wrong name. Sign up or enter the correct name' }
        flash[:notice] = 'Wrong name. Sign up or enter the correct name'
        format.html { render :new }
        format.json { render json: { error: 'failed login' }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:current_user_id] = @current_user = nil
    respond_to do |format|
      format.html { redirect_to sign_in_url, notice: 'You have successfully logged out.' }
      format.json { head :no_content }
    end
  end

  private

  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end
end
