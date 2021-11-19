import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ['total']

  connect() {
    console.log('connected')
    this.load()
  }

  load() {
    console.log(this.urlValue)
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => this.totalTarget.innerHTML = html)
  }
}
