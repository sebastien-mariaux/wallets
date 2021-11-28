# frozen_string_literal: true

class ProfilesController < AuthenticatedController
  before_action :load_profile, only: %i[edit update]

  def edit
  end

  def update
    if current_user.update(allowed_params)
      redirect_to root_path, notice: t('.success')
    else
      flash.now.alert = t('.failure')
      render :edit, status: :unprocessable_entity, notice: 'failure'
    end
  end

  private

  def allowed_params
    params.require(:user).permit(:investment, :precision, :main_currency, 
                                 :display_local, :display_usd, :display_btc)
  end

  def load_profile
    @profile = current_user
  end
end
