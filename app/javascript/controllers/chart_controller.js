import { Controller } from "stimulus"
const Chart = require('chart.js');

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.getChartData()
  }

  initChart(data) {
    var ctx = document.querySelector('#wallet-pie');
    let params = this.chartParams(data)
    console.log(params)
    new Chart(ctx, params);
    this.element.querySelector('.spinner-container').remove()
  }

  getChartData(callback) {
    fetch(this.urlValue)
    .then(response =>  response.json())
    .then(data => this.initChart(data))
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








  


 