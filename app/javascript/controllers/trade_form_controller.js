import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ['form', 'formWrapper', 'firstField', 'resetField', 'coinField', 'walletField']

  create(event) {
    event.preventDefault()
    Rails.fire(this.formTarget, 'submit')
  }

  handleSuccess() {
    this.sendEvent()
    $(this.firstFieldTarget).focus()
    $(this.resetFieldTargets).val('')
    $(this.element).find('input').removeClass('is-invalid')
  }
  
  handleError(event) {
    $(this.formWrapperTarget).html(event.detail[2].responseText)
  }
  
  sendEvent() {
    const event = new CustomEvent("add-trade", {detail: this.eventData()})
    window.dispatchEvent(event)
  }

  eventData() {
    return {
      coinIds: this.coinFieldTargets.map(field =>  { return $(field).val() }), 
      walletId: $(this.walletFieldTarget).val()
    }
  }
}
