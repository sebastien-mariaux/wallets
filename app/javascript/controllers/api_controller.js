import { Controller } from "stimulus"

export default class extends Controller {
  static values = { url: String }

  load() {
    this.element.querySelector('.spinner').classList.remove('hidden')
    this.element.setAttribute('disabled', true)
    fetch(this.urlValue)
      .then(response =>  response.json())
      .then(data => this.waitForCompletion(data.id))
  }

  waitForCompletion(process_id) {
    setTimeout(() => this.checkProcess(process_id), 3000)
  }

  checkProcess(process_id) {
    let url = '/app_processes/' + process_id
    fetch(url)
    .then(response => response.json())
    .then(data => this.handleProcessResponse(data))
  }

  handleProcessResponse(data) {
    if (data.status == 'done') {
       this.onProcessSuccess(data)
    } else {
      this.waitForCompletion(data.id)
    }
  }

  onProcessSuccess(data) {
    this.element.querySelector('.spinner').classList.add('hidden')
    this.element.removeAttribute('disabled')
    this.displayFlash(data.message)
    const event = new CustomEvent("update-data")
    window.dispatchEvent(event)    
  }

  displayFlash(message) {
    document.querySelector('#flash').innerHTML = message
    document.querySelector('#flash').classList.remove('hidden')
    setTimeout(() => this.hideFlash(), 3000)
  }

  hideFlash() {
    document.querySelector('#flash').innerHTML = ""
    document.querySelector('#flash').classList.add('hidden')
  }
}
