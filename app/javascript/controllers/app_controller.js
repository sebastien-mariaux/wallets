
import { Controller } from "stimulus"
import * as bootstrap from 'bootstrap'

export default class extends Controller {
  connect() {
    this.initTooltips()
    this.hideNotices()
  }

  initTooltips() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  }

  hideNotices() {
    var notice = $('.event-notice')
    if (notice === null) {
      return
    }

    setTimeout(() => {
      notice.fadeOut(1000)
    }, 5000);
  }
}