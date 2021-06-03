import Chartkick from "chartkick";



const initChartkickWeek = () => {
  const div_week = document.getElementById('chart-week');
  if (div_week) {
    const data_week = JSON.parse(div_week.dataset.steps);
    new Chartkick.ColumnChart("chart-week", data_week, { colors: ["rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 0.5)", "rgba(109, 168, 179, 1)"], dataset: { borderWidth: 3, borderColor: 'rgba(109, 168, 179, 1)' }});
  };}

const initChartkickMonth = () => {
  const div_month = document.getElementById('chart-month');
  if (div_month) {
    const data_month = JSON.parse(div_month.dataset.steps);
    new Chartkick.LineChart("chart-month", data_month, { curve: true, colors: ["rgb(109, 168, 179)"], label: "Nombre de pas" });
  };}

const initChartkickPreviousMonth = () => {
  const div_previous_month = document.getElementById('chart-previous-month');
  if (div_previous_month) {
    const data_previous_month = JSON.parse(div_previous_month.dataset.steps);
    new Chartkick.LineChart("chart-previous-month", data_previous_month, { curve: true, colors: ["rgb(109, 168, 179)"], label: "Nombre de pas" });
  };}

const initChartkickTeamOne = () => {
  const div_team_one = document.getElementById('chart-team-one');
  if (div_team_one) {
    const data_team_one = JSON.parse(div_team_one.dataset.steps);
    new Chartkick.ColumnChart("chart-team-one", data_team_one, {
      colors: ["rgb(109, 168, 179)"], label: "Nombre de pas" });
  };}

const initChartkickTopCompanies = () => {
  // const div_home = document.getElementById('chart-home-company-1');
  const three_companies = document.querySelectorAll('*[id^="chart-home-company"]');
  if (three_companies) {
    three_companies.forEach((company, index) => {
      // console.log(index + 1);
      const data_company = JSON.parse(company.dataset.steps);
      new Chartkick.BarChart(`chart-home-company-${index + 1}`, data_company, { colors: ["rgb(109, 168, 179)", "rgba(109, 168, 179, 0.2)"] });
    });
  };
}

const initChartkickTopWalkers = () => {
  // const div_home = document.getElementById('chart-home-company-1');
  const three_walkers = document.querySelectorAll('*[id^="chart-home-walker"]');
  if (three_walkers) {
    three_walkers.forEach((walker, index) => {
      // console.log(walker);
      // console.log(index + 1);
      const data_walkers = JSON.parse(walker.dataset.steps);
      new Chartkick.BarChart(`chart-home-walker-${index + 1}`, data_walkers, { colors: ["rgb(109, 168, 179)", "rgba(109, 168, 179, 0.2)"]});
    });
  };
}


export { initChartkickWeek };
export { initChartkickMonth };
export { initChartkickTeamOne };
export { initChartkickTopCompanies };
export { initChartkickTopWalkers };
export {initChartkickPreviousMonth};


