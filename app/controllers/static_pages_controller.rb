class StaticPagesController < ApplicationController

  def home
    @products=Product.where(available: true).order("RANDOM()").limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  
  #Разделы 
  def style
    @title = "Стиль"
    @products=Product.where(category1: 1,available: true).order('created_at DESC').limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  def movies_and_music
    @title = "Кино и музыка"
    @products=Product.where(category1: 2,available: true).order('created_at DESC').limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  def vehicle
    @title = "Транспорт"
    @products=Product.where(category1: 3,available: true).order('created_at DESC').limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  def tech
    @title = "Технологии"
    @products=Product.where(category1: 4,available: true).order('created_at DESC').limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  def sport
    @title = "Спорт"
    @products=Product.where(category1: 5,available: true).order('created_at DESC').limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  def stuff
    @title = "Другое"
    @products=Product.where(category1: 6,available: true).order('created_at DESC').limit(1000)
    @products = @products.paginate(page: params[:page],per_page: 14)
  end
  ##############

  def about 
    @title = "О сайте"
  end

  def contact
    @title = "Контакты"
  end

  def search
    @title = "Поиск"
  end

  def error
    @title = "Публикация проверяется"
  end

  def email
  end
  
  def rules
    @title = "Правила"
  end 
end
