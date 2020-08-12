class SessionsController < ApplicationController
  
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
    # @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @user = current_user
  end

  # GET /sessions/new
  def new

  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create

    @user = User.find_by(name: params[:name])
    session[:current_user_id] = @user.id

    respond_to do |format|
      if @user

        format.html { redirect_to signed_in_path, notice: 'You have successfully logged in'}
        format.json { render @user, status: :'logged in' }
      else
        format.html { render :new }
        format.json { render json: {error: "failed login"}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  # def update
  #   respond_to do |format|
  #     if @session.update(session_params)
  #       format.html { redirect_to @session, notice: 'Session was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @session }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @session.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])

  end
    # Use callbacks to share common setup or constraints between actions.
    # def set_session
      # # @session = Session.find(params[:id])
      # p "lllllJJJJJJJJJJJ", params[:name]
      # user = User.find_by(name: params[:name])
      # p user
      # # session[:current_user_id] = user[:name]
      # # session[:current_user_name] = user.name
      # session[:current_user_name] = params[:name]
      # @session = "Marylene"
    # end

    # Only allow a list of trusted parameters through.
    # def session_params
    #   params.fetch(:session, {}).permit(:name)
    # end
end
# Steps we still need to authenticate the user
# Authenticate user before signing them in
# Use flash to display name