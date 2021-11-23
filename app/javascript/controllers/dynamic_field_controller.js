import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static values = { url: String }
  static targets = ['display', 'input']

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.displayTarget.innerHTML = html)
  }

  displayForm() {
    this.inputTarget.type = 'number'
    this.inputTarget.value = this.quantityValue()
    this.displayTarget.classList.add('hidden')
    this.inputTarget.focus()
  }

  hideForm() {
    this.inputTarget.type = 'hidden'
    this.load()
    this.displayTarget.classList.remove('hidden')
  }

  // quantityInput() {
  //   return this.element.querySelector("input[name='quantity']")
  // }

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
