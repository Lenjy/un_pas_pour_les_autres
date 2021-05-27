

const calculate = (conversion_proposal) => {
    const steps = parseInt(document.querySelector('#total_steps').value);
    const donation_output = document.querySelector('#donation_output');
    let steps_calculation = steps / parseInt(conversion_proposal.value);
    donation_output.value = steps_calculation;
}

const donate_event = () => {
    const conversion_proposal = document.querySelector('#conversion_proposal');
    if (conversion_proposal) {
    conversion_proposal.addEventListener('keyup', (event) => {
        calculate(conversion_proposal)

    });    
}
    /* const conversion_proposal.addEventListener('change', calculate); */
}


export {donate_event}
