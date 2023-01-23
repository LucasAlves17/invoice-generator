class Api::UsersController < ApplicationController

  # POST /users
  def create
    result = User::GenerateToken.call(email: params[:email])

    if result.success?
      render json: { message: "A confirmation email has been sent to your email address. Please check your inbox to activate your account." }, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  # GET /users/confirm
  def confirm
    result = User::ConfirmToken.call(token_to_confirm: params[:token])

    if result.success?
      render json: { message: "Account successfully activated!" }, status: :ok
    else
      render json: { error: result.errors }, status: :not_found
    end
  end
end