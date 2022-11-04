import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    window.addEventListener('update-data', () => this.load(), false)
  }

  load() {
    fetch(this.urlValue)
      .then(response => response.json())
      .then(data => this.element.innerHTML = data.value)
  }
}
