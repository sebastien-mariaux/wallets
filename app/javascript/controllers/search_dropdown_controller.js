import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = [ "results", "input" ]

  load(event) {
    let value = (event.target).value
    if ( value.length < 3 ) { return }

    let url = this.urlValue + "?query=" + value
    fetch(url)
      .then(response => response.text())
      .then(html => this.resultsTarget.innerHTML = html)
  }

  select(event) {
    let resultId = event.target.dataset.id
    this.inputTarget.value = resultId
    this.resultsTarget.innerHTML = ''
  }

  autoFill(event) {
    let resultName = event.target.dataset.name
    let resultCode = event.target.dataset.code
    
    document.querySelector('#coin_name').value = resultName
    document.querySelector('#coin_code').value = resultCode
  }

  selectAndFill(event) {
    this.select(event)
    this.autoFill(event)
  } 
}
