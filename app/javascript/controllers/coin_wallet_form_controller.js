import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ['quantity']

  connect() {
    this.load()
  }

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.quantityTarget.innerHTML = html)
  }

  displayForm() {
    this.quantityInput().type = 'number'
    this.quantityInput().value = this.quantityValue()
    this.element.querySelector(".quantity-value").classList.add('hidden')
    this.quantityInput().focus()
  }

  quantityInput() {
    return this.element.querySelector("input[name='quantity']")
  }

  updateValue() {
    let newValue = this.quantityInput().value
  }

  quantityValue() {
    let rawValue = this.quantityTarget.innerHTML
    return parseFloat(rawValue) || 0
  }
}
