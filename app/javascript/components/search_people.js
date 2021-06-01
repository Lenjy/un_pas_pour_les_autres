import { csrfToken } from "@rails/ujs";

const anchor = document.querySelector('#user-list')

const searchPeople = (event) => {
  if (event) {
    console.log(event.currentTarget.value);
    fetch("/users/search", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        'Accept': "application/json",
        'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ query: event.currentTarget.value })
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data.html);
        anchor.innerHTML = "";
        anchor.insertAdjacentHTML("beforeend", data.html);
      });
  }
};

const input = document.querySelector("#search");
if (input) {
  input.addEventListener("keyup", searchPeople);
}

export { searchPeople }
