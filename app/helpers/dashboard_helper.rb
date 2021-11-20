module DashboardHelper
  def total_variation
    delta = (CoinWallet.total_eur_value / Config.first.investment_eur - 1) * 100
    direction = delta >= 0 ? 'green' : 'red'
    tag.span class: direction do
      "#{number_with_precision(delta, precision: 2)} %"
    end
  end
end