import Chartkick from "chartkick";

const initChartkickWeek = () => {
  const div_week = document.getElementById('chart-week');
  console.log(div_week);
  const data_week = JSON.parse(div_week.dataset.steps);
  console.log(data_week);
  new Chartkick.ColumnChart("chart-week", data_week);
}

const initChartkickMonth = () => {
  const div_month = document.getElementById('chart-month');
  const data_month = JSON.parse(div_month.dataset.steps);
  new Chartkick.LineChart("chart-month", data_month, { curve: true });
}

const initChartkickTeamOne = () => {
  const div_team_one = document.getElementById('chart-team-one');
  const data_team_one = JSON.parse(div_team_one.dataset.steps);
  new Chartkick.ColumnChart("chart-team-one", data_team_one);
}

export { initChartkickWeek };
export { initChartkickMonth };
export { initChartkickTeamOne };
