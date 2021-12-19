import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ['form', 'formWrapper', 'firstField', 'resetField']

  create(event) {
    event.preventDefault()
    Rails.fire(this.formTarget, 'submit')
  }

  handleSuccess() {
    const event = new CustomEvent("update-quantity")
    window.dispatchEvent(event)
    $(this.firstFieldTarget).focus()
    $(this.resetFieldTargets).val('')
    $(this.element).find('input').removeClass('is-invalid')
  }

  handleError(event) {
    $(this.formWrapperTarget).html(event.detail[2].responseText)
  }
}
