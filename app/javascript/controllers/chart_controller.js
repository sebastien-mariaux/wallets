import { Controller } from "stimulus"
const Chart = require('chart.js');

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.initChart()
    window.addEventListener('update-data', () => this.initChart(), false)
  }

  createChart(data) {
    var ctx = document.querySelector('#wallet-pie');
    let params = this.chartParams(data)
    new Chart(ctx, params);

    var spinnerElt = $(this.element).find('.spinner-container')
    if (spinnerElt != null) {
      spinnerElt.remove()
    }
  }

  initChart() {
    fetch(this.urlValue)
      .then(response => response.json())
      .then(data => this.createChart(data))
  }

  chartParams(walletData) {
    return {
      type: 'pie',
      data: {
        labels: walletData.labels,
        datasets: [{
          label: 'Wallet repartition',
          data: walletData.values,
          backgroundColor: this.getColors(walletData.labels),
          hoverOffset: 4
        }],
      }
    }
  }

  getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }

  getColors(labels) {
    return labels.map(x => this.getRandomColor());
  }
}











