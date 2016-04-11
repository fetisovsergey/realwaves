class ProductsController < ApplicationController
  before_action :signed_in_user, only: [:upvote, :downvote]
  before_action :correct_user,   only: [:destroy, :edit, :update]
  before_action :admin_user,     only: [:activate, :deactivate]
  def index
    if params[:search] and !params[:search].blank? and params[:search].size > 2
      @title = "Результаты поиска"
      @parameter = params[:search]
      products = Product.where(available: true)
      @products = products.search(params[:search]).to(23)
    else
      redirect_to search_path
    end
  end

  def activate
    product = Product.find(params[:id])
    if product
      product.product_activate
      #Отправка почтового уведомления автору поста
      UserMailer.product_email_activate(product).deliver
      ###########################################
      respond_to do |format|
        format.html { redirect_to :back }
        format.js 
      end
    else
      redirect_to manage_user_path(current_user)
    end
  end

  def deactivate
    product = Product.find(params[:id])
    if product
      product.product_deactivate
      respond_to do |format|
        format.html { redirect_to :back }
        format.js 
      end
    else
      redirect_to manage_user_path(current_user)
    end
  end 

  def show
    @product = Product.find(params[:id])
    if @product.available == true
	    id = @product.id
	    category1 = @product.category1
	    @other_products = Product.where("category1 == ? AND id != ? AND available == ?",category1,id,true).order("RANDOM()").limit(3)
	else
		redirect_to error_path
	end
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = "Пост создан"

      #Отправка почтового уведомления автору поста
      UserMailer.product_email(@product).deliver
      ###########################################
      
      #Отправка почтового уведомления модератору
      UserMailer.product_email_moderator(@product).deliver
      ###########################################

      #Делает публикацию активной
      #@product.product_activate
      #redirect_to @product
      ###########################

      redirect_to manage_user_path(current_user)
    else
      render 'edit'
    end
  end

  def edit
    @title = "Редактирование"
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Пост обновлен"
      #Отправка почтового уведомления модератору
      UserMailer.product_change_email_moderator(@product).deliver
      ###########################################
      redirect_to manage_user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to manage_user_path(current_user)
  end

  def upvote
    @product = Product.find(params[:id])
    @product.save
    @product.liked_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end
  end

  def downvote 
     @product = Product.find(params[:id])
     @product.save
     @product.unliked_by current_user
     respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end
  end
  
  private
  
    def product_params
      params.require(:product).permit(:photo1,:photo2,:photo3,:photo4,:photo5,:available,:status,:title,:link,:company_name,:content,:category1)
    end
    def correct_user
      if !current_user.admin?
        @product = current_user.products.find_by(id: params[:id])
      else
        @product = Product.find_by(id: params[:id])
      end
      redirect_to root_url if @product.nil?
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
