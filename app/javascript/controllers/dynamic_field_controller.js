import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static values = { url: String, coin: String, wallet: String }
  static targets = ['display', 'input']

  connect() {
    this.element.classList.add('dynamic-field')
  }

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.displayTarget.innerHTML = html)
  }

  reloadQuantity(event) {
    let coinIds = event.detail.coinIds
    let walletId = event.detail.walletId
    if ( walletId == this.walletValue && coinIds.includes(this.coinValue) ) {
      this.load()
    }
  }

  displayForm() {
    this.inputTarget.type = 'text'
    this.inputTarget.value = this.quantityValue()
    this.displayTarget.classList.add('hidden')
    this.inputTarget.focus()
  }

  hideForm() {
    this.inputTarget.type = 'hidden'
    this.load()
    this.displayTarget.classList.remove('hidden')
  }

  updateValue() {
    let form = this.element.querySelector('form')
    Rails.fire(form, 'submit')
  }

  quantityValue() {
    let rawValue = this.displayTarget.innerHTML
    return parseFloat(rawValue) || 0
  }

  handleSuccess() {
    this.hideForm()
    const event = new CustomEvent("update-quantity")
    window.dispatchEvent(event)
  }

  handleError() {
    this.hideForm()
  }
}
