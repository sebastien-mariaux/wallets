import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ['total']

  connect() {
    window.addEventListener('update-data', () => this.load(), false)
  }

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.totalTarget.innerHTML = html)
  }
}
