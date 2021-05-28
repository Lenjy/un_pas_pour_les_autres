import Chartkick from "chartkick";

const initChartkickWeek = () => {
  const div_week = document.getElementById('chart-week');
  console.log(div_week);
  const data_week = JSON.parse(div_week.dataset.steps);
  console.log(data_week);
  new Chartkick.ColumnChart("chart-week", data_week, { colors: ["rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 1)"]});
}

const initChartkickMonth = () => {
  const div_month = document.getElementById('chart-month');
  const data_month = JSON.parse(div_month.dataset.steps);
  new Chartkick.LineChart("chart-month", data_month, { curve: true, colors: ["rgb(109, 168, 179)"], label: "Nombre de pas" });
}

const initChartkickTeamOne = () => {
  const div_team_one = document.getElementById('chart-team-one');
  const data_team_one = JSON.parse(div_team_one.dataset.steps);
  new Chartkick.ColumnChart("chart-team-one", data_team_one, { colors: ["rgb(109, 168, 179)"], label: "Nombre de pas"  });
}

export { initChartkickWeek };
export { initChartkickMonth };
export { initChartkickTeamOne };
