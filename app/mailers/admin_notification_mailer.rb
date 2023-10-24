class AdminNotificationMailer < ApplicationMailer
  def new_admin_notification_email
    @statement = params[:statement]

    mail(to: 'admin@main.com', subject: "You got a new statement!")
  end
end