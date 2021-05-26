import Chartkick from "chartkick";

const initChartkickWeek = () => {
  const div_week = document.getElementById('chart-week');
  const data_week = JSON.parse(div_week.dataset.steps);
  new Chartkick.ColumnChart("chart-week", data_week);
}

const initChartkickMonth = () => {
  const div_month = document.getElementById('chart-month');
  const data_month = JSON.parse(div_month.dataset.steps);
  new Chartkick.LineChart("chart-month", data_month);
}

export { initChartkickWeek };
export { initChartkickMonth };
