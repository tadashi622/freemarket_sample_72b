class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update_profile]
  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
      @user = User.new(sign_up_params)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :new and return
      end
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      session["devise.regist_data"][:user]["password_confirmation"] = params[:user][:password_confirmation]
      @address = @user.build_address
      render :new_address
    else
      @user = User.new(sign_up_params)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :new and return
      end
      session["devise.regist_data"] = {user: @user.attributes}
      session["devise.regist_data"][:user]["password"] = params[:user][:password]
      @address = @user.build_address
      render :new_address
    end
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    if @user.save
      sign_in(:user, @user)
      render :create_address
    else
      render :new
    end
  end

  def edit_profile
    @profile = User.find(params[:id])
  end

  def update_profile
    @profile = User.find(params[:id])
    if @profile.update(account_update_params)
      sign_in(:user, @profile)
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = @profile.errors.full_messages
      render :edit_profile
    end
  end
  # def update_profile
  #   @profile = User.find(params[:id])
  #   if @profile.update_without_password(account_update_params)
  #     sign_in @profile, bypass: true
  #     set_flash_message :notice, :updated
  #     redirect_to user_path(current_user.id)
  #   else
  #     flash.now[:alert] = @profile.errors.full_messages
  #     render :edit_profile
  #   end
  # end
  
  def edit_phone
    @phone = User.find(params[:id])
  end

  def update_phone
    @phone = User.find(params[:id])
    if @phone.update(account_update_params)
      sign_in(:user, @phone)
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = @phone.errors.full_messages
      render :edit_phone
    end
  end
  
  def edit_introduce
    @introduce = User.find(params[:id])
  end

  def update_introduce
    @introduce = User.find(params[:id])
    if @introduce.update(account_update_params)
      sign_in(:user, @introduce)
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = @introduce.errors.full_messages
      render :edit_introduce
    end
  end

  def destroy
    if @user.destroy
      redirect_to deletion_users_path
    else
      flash[:notice] = 'アカウント削除できませんでした'
      redirect_to signout_users_path(current_user.id)
    end
  end

# < 編集後 ユーザーページへ >
  def after_update_path_for(resource)
    user_path(resource)
  end


  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end
  
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname,:user_image, :first_name,:last_name,:first_name_read,:last_name_read,:phone_num, :birthday , :introduction,:current_password ])
  end

  def address_params
    params.require(:address).permit(:zip_code, :prefecture_id, :city, :address1, :address2)
  end

  # def update_resource(resource, params)
  #   resource.update_without_password(params)
  # end



  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
