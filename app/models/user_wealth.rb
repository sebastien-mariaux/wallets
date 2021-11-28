class UserWealth 
  def initialize(user)
    @user = user
  end

  %w[eur usd btc].each do |currency|
    define_method "total_#{currency}_value" do
      @user.coin_wallets.all.inject(0) do |sum, wallet|
        sum += wallet.send("#{currency}_value")
      end
    end
  end

  def delta_percent(currency = 'eur')
    return unless can_compute_delta?(currency)

    delta(currency) * 100
  end

  def delta(currency = 'eur')
    return unless can_compute_delta?(currency)

    (send("total_#{currency}_value") / @user.investment_eur.to_f - 1)
  end

  private

  def can_compute_delta?(currency)
    raise NotImplementedError unless currency == 'eur'

    return @user.investment_eur.present? &&  @user.investment_eur.positive?
  end
end