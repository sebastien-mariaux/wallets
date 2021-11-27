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

  def delta_percent(currency)
    delta(currency) * 100
  end

  def delta(currency)
    (send("total_#{currency}_value") / @user.investment_eur.to_f - 1)
  end
end