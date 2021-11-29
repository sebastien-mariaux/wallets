import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['input', 'output']

  compute() {
    let expression = $(this.inputTarget).val()
    console.log(expression)
    let result = eval(expression)
    $(this.outputTarget).text(result)
  }
}
