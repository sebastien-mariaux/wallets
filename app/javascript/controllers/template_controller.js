import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ['template']

  load() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.templateTarget.innerHTML = html)
  }
}
