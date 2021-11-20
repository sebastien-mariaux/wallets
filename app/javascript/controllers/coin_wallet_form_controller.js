import { Controller } from "stimulus"
import Rails from "@rails/ujs";

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
    this.quantityTarget.classList.add('hidden')
    this.quantityInput().focus()
  }

  hideForm() {
    this.quantityInput().type = 'hidden'
    this.load()
    this.quantityTarget.classList.remove('hidden')
  }

  quantityInput() {
    return this.element.querySelector("input[name='quantity']")
  }

  updateValue() {
    let form = this.element.querySelector('form')
    Rails.fire(form, 'submit')
  }

  quantityValue() {
    let rawValue = this.quantityTarget.innerHTML
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
