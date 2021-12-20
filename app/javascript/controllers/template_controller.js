import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String, coin: String, wallet: String }
  static targets = ['template']

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.templateTarget.innerHTML = html)
  }

  reload(event) {
    let coinId = event.detail.coinId
    let walletId = event.detail.walletId
    if ( walletId === this.walletValue || coinId === this.coinValue || this.alwaysUpdate() ) {
      this.load()
    } 
  }

  alwaysUpdate() {
    return this.coinValue === "" && this.walletValue === ""
  }

}
