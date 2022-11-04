# frozen_string_literal: true

class UserWealth
  def initialize(user)
    @user = user
  end

  def total_ref_value
    total_value(@user.investment_currency)
  end

  def total_value(currency)
    @user.coin_wallets.all.inject(0) do |sum, wallet|
      sum += wallet.currency_value(currency)
    end
  end

  # %w[eur usd btc].each do |currency|
  #   define_method "total_#{currency}_value" do
  #     @user.coin_wallets.all.inject(0) do |sum, wallet|
  #       sum += wallet.send("#{currency}_value")
  #     end
  #   end
  # end

  def delta_percent
    return unless can_compute_delta?

    delta * 100
  end

  def delta
    return unless can_compute_delta?

    total_ref_value / @user.investment.to_f - 1
  end

  private

  def can_compute_delta?
    @user.investment.present? && @user.investment.positive?
  end
end
