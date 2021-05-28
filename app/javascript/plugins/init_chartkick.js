import Chartkick from "chartkick";

const initChartkickWeek = () => {
  const div_week = document.getElementById('chart-week');
<<<<<<< colors
  console.log(div_week);
  const data_week = JSON.parse(div_week.dataset.steps);
  console.log(data_week);
  new Chartkick.ColumnChart("chart-week", data_week, { colors: ["rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 1)"]});
=======

  if (div_week){
    console.log(div_week);
    const data_week = JSON.parse(div_week.dataset.steps);
    console.log(data_week);
    new Chartkick.ColumnChart("chart-week", data_week);
  }
>>>>>>> master
}

const initChartkickMonth = () => {
  const div_month = document.getElementById('chart-month');
<<<<<<< colors
  const data_month = JSON.parse(div_month.dataset.steps);
  new Chartkick.LineChart("chart-month", data_month, { curve: true, colors: ["rgb(109, 168, 179)"], label: "Nombre de pas" });
=======
  if (div_month){
    const data_month = JSON.parse(div_month.dataset.steps);
    new Chartkick.LineChart("chart-month", data_month, { curve: true });
  }
>>>>>>> master
}

const initChartkickTeamOne = () => {
  const div_team_one = document.getElementById('chart-team-one');
<<<<<<< colors
  const data_team_one = JSON.parse(div_team_one.dataset.steps);
  new Chartkick.ColumnChart("chart-team-one", data_team_one, { colors: ["rgb(109, 168, 179)"], label: "Nombre de pas"  });
=======
  if (div_team_one) {
    const data_team_one = JSON.parse(div_team_one.dataset.steps);
    new Chartkick.ColumnChart("chart-team-one", data_team_one);
  }
>>>>>>> master
}

export { initChartkickWeek };
export { initChartkickMonth };
export { initChartkickTeamOne };
