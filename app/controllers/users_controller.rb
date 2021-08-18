class UsersController < ApplicationController
  skip_before_action :authorize
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_logged_in_user, only: [:show_user_orders, :show_user_line_items]

  # GET /users or /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def show_user_line_items
    @items = @user.line_items.paginate(page: params[:page], per_page: 5)
  end

  def show_user_orders
    @orders = @user.orders.paginate(page: params[:page], per_page: 5)
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if !@user.try(:authenticate, params[:user][:current_password])
        format.html { redirect_to edit_user_path(@user), notice: "User #{@user.name} current password not matched" }
      elsif @user.update(user_params)
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    begin
      if @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: "User #{@user.name} deleted." }
          format.json { head :no_content }
        end
      else
        redirect_to users_url, alert: @user.errors['email']
      end
    rescue Exception => e
      redirect_to users_url, alert: e.message
    end
  end

rescue_from 'User::Error' do |exception|
    redirect_to users_url, notice: exception.message
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_logged_in_user
      @user = User.find(session[:user_id])
    end
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
