
import { Controller } from "stimulus"
import * as bootstrap from 'bootstrap'



export default class extends Controller {
  connect() {
    this.initTooltips()
  }

  initTooltips() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  }
}