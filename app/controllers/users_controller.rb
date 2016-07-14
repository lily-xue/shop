class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def pro_activate
	user = User.find_by_name(params[:name])
	if (user != nil && user.IsActived == "f" && user.ActiveCode ==params[:ActiveCode] )then
		user.update_attribute(:IsActived, true)
		flash[:notice] = "激活成功"
	elsif user != nil and user.IsActived == "t" then
		flash[:notice] = "你已经激活过了~"
	else 
		flash[:notice] = "激活失败"
	end
  end


  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.ActiveCode = rand(Time.now.to_i).to_s
   @user.IsActived = false
    respond_to do |format|
      if @user.save
    SignupMailer.sendmail(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :ActiveCode,:IsActived, :department, :password, :email)
    end
end
