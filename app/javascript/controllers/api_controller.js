import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }

  load() {
      fetch(this.urlValue)
  }
}
