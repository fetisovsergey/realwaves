class UserMailer < ActionMailer::Base
 default from: 'info@yourwaves.ru'
 def welcome_email(user)
    @user = user
    @url  = 'http://yourwaves.ru/signin'
    mail(to: @user.email, subject: 'Добро пожаловать на YourWaves')
 end
 def update_email(user)
    @user = user
    mail(to: @user.email, subject: 'YourWaves: Изменение данных учетной записи')
 end
 def product_email(product)
 	@product = product
 	@user = User.find(product.user_id)
    mail(to: @user.email, subject: 'YourWaves: Размещение публикации')
 end
 def product_email_moderator(product)
 	@product = product
 	@user = User.find(product.user_id)
    mail(to: 'info@yourwaves.ru', subject: 'YourWaves: Размещение публикации')
 end
 def product_change_email_moderator(product)
 	@product = product
 	@user = User.find(product.user_id)
    mail(to: 'info@yourwaves.ru', subject: 'YourWaves: Изменение публикации')
 end
  def product_email_activate(product)
 	@product = product
 	@user = User.find(product.user_id)
    mail(to: @user.email, subject: 'YourWaves: Ваша публикация одобрена')
 end
end
