// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = ['form', 'formWrapper', 'indexBody', 'firstField']

//   create(event) {
//     event.preventDefault()
//     Rails.fire(this.formTarget, 'submit')
//   }

//   handleSuccess(event) {
//     $(this.indexBodyTarget).prepend(event.detail[2].responseText)
//     $(this.firstFieldTarget).focus()
//   }

//   handleDashboardSuccess() {
//     const event = new CustomEvent("update-quantity")
//     window.dispatchEvent(event)
//     $(this.firstFieldTarget).focus()
//   }

//   handleError(event) {
//     $(this.formWrapperTarget).html(event.detail[2].responseText)
//   }
// }
