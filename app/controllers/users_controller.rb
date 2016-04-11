class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :show, :index]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: [:users, :destroy]
  
  def show
    @user = User.find(params[:id])
    @products = @user.products.last(100)
    @votes = Vote.where(voter_id: @user.id)
  end
  

  def manage
    @title = "Управление контентом"
    @user = User.find(params[:id])
    if current_user?(@user)
      if current_user.admin?
        @products = Product.order('updated_at DESC').paginate(page: params[:page],per_page: 100)
      else
        @products = @user.products.paginate(page: params[:page],per_page: 100)
      end
    end
  end

  def users
    @title = "Пользователи"
    @users = User.all.paginate(page: params[:page],per_page: 100)
  end

  def new_post
    @title = "Создать публикацию"
    @user = User.find(params[:id])
    if current_user?(@user)
      @product = @user.products.build
    end
  end

  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      ###############
      #sign_in @user
      #redirect_to root_url
      ###############
      redirect_to email_url
    else
      render 'new'
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      redirect_to signin_url
    else
      redirect_to root_url
    end
  end
 
  
  def edit
    @title = "Настройки профиля"
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Профиль пользователя обновлен"
      UserMailer.update_email(@user).deliver
      reirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :about, :weblink, :surname, :city, :password, :password_confirmation, :avatar)
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
