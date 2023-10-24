# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_statement, only: %i[show edit update destroy]
  before_action :set_statement_types, only: %i[create new]

  def show; end

  def edit
    render :edit
  end

  def new
    @statement = Statement.new
    render :new
  end

  def create
    @statement = Statement.new(statement_params)

    @statement.user_id = current_user.id
    @statement.status = 'pending'

    if @statement.save
      AdminNotificationMailer.with(statement: @statement).new_admin_notification_email.deliver_later

      flash[:success] = "New statement successfully added!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Statement creation failed"
      render :new
    end
  end

  def update
    if !current_user.admin? && @statement.update(statement_params)
      AdminNotificationMailer.with(statement: @statement).new_admin_notification_email.deliver_later

      flash[:success] = "Statement successfully updated!"
      redirect_to user_path(current_user)
    elsif current_user.admin? && @statement.update(statement_admin_params)
      NotificationMailer.with(statement: @statement).new_notification_email.deliver_later

      flash[:success] = "Statement successfully updated!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Statement update failed"
      render :edit
    end
  end

  def destroy
    @statement.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_statement
    @statement = Statement.find(params[:id])
  end

  def set_statement_types
    @statement_types = StatementType.all
  end

  def statement_params
    params.require(:statement).permit(
      :start_date,
      :end_date,
      :statement_type_id
    )
  end

  def statement_admin_params
    params.require(:statement).permit(
      :status
    )
  end
end
