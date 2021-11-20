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
  }

  getChartData(callback) {
    fetch(this.urlValue)
    .then(response =>  response.json())
    .then(data => this.initChart(data))
  }

  chartParams(data) {
    return {
      type: 'pie',
      data: {
        labels: data.labels,
        datasets: [{
          label: 'Wallet repartition',
          data: data.values,
          hoverOffset: 4
        }],
      }
    }
  }

  // json.dumps({
  //   "labels": [c.name for c in currencies],
  //   "values": [round(c.usd_value / total_value * 100, 2) 
  //              for c in currencies]
  // })

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








  


 