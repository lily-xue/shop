class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user,only: [:edite,:update,:destroy,:index]
  before_action :correct_user,only: [:edite,:update]
  before_action :admin_user,only: [:destroy]
 # GET /users
  # GET /users.json
  def pro_activate
    set_activate
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
  def get_activate_email
  end

  def send_activate_email
    @user = User.find_by(email:params[:email])
    if @user && @user.IsActived == "f"
      SignupMailer.sendmail(@user).deliver
      flash[:notice] = "已经发送验证码到您邮箱，请查收"
      redirect_to root_path
    elsif @user && @user.IsActived == "t"
      flash[:notice] = "用户已经激活，请勿重复激活"
      # redirect_to :action => "new"
      redirect_to  "/get_activate_email"
    elsif @user == nil
      flash[:notice] = "用户不存在，请先注册"
      redirect_to :action => "new"
    else
      flash[:notice] = "验证码发送失败，请重试"
        redirect_to  "/get_activate_email"
    end
  end

  def create
    @user = User.new(user_params)
    @user.ActiveCode = rand(Time.now.to_i).to_s
   @user.IsActived = false
    respond_to do |format|
      if @user.save
        SignupMailer.sendmail(@user).deliver
        format.html { redirect_to @user, notice: '账号注册成功，已经发送激活码到您邮箱，请登录邮箱激活账号' }
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
@user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        sign_in @user
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
@user = User.find(params[:id])
    @user.destroy
flash[:notice] = "账号删除成功"
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
      params.require(:user).permit(:name, :ActiveCode,:IsActived, :department, :password,:password_confirmation, :email)
    end


    def correct_user
   @user = User.find(params[:id])
   redirect_to (root_path) unless current_user?(@user)
   end

  #  def admin_user
  #  redirect_to (root_path) unless current_user.admin?
  #  end
   def admin_user#如果不是管理员，则跳转到根页面
      @current_user = User.find_by(id: session[:user_id])
      redirect_to(root_path) unless @current_user.admin?
    end





end
