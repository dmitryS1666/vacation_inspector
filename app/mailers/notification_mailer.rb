class NotificationMailer < ApplicationMailer
  def new_notification_email
    @statement = params[:statement]

    mail(to: User.find(@statement.user_id).email, subject: "You got a new statement!")
  end
end