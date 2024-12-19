const xValidValues = [-5, -4, -3, -2, -1, 0, 1, 2, 3];
let selectedXBtn = null;

function showNotification(message) {
    const notification = document.getElementById('notification');
    notification.textContent = message;
    notification.style.display = 'block';
    notification.style.opacity = 1;

    setTimeout(() => {
        notification.style.opacity = 0;
        setTimeout(() => {
            notification.style.display = 'none';
        }, 500);
    }, 3000);
}

function onSubmitClick() {
    event.preventDefault()
    console.log("Clicked on submit data");
    try {
        //event.preventDefault();
        const xValue = selectedXBtn;
        const yValue = document.getElementById('y-text-input').value;
        const rValue = document.getElementById('r-text-input').value;

        if (xValue === null || yValue.trim() === "" || rValue.trim() === "") {
            showNotification("Не заполнены все обязательные поля");
            return;
        }

        const x = parseFloat(xValue);
        const y = parseFloat(yValue.replace(',', '.')).toFixed(10);
        const r = parseFloat(rValue.replace(',', '.')).toFixed(10);

        if (isNaN(x) || !validateSelection(x, xValidValues)) {
            showNotification("Значение х должно быть в диапазоне от -5 до 3. Выбери кнопочкой");
            return;
        }

        if (isNaN(y) || y < -5 || y > 3) {
            showNotification("Значение y должно быть в диапазоне от -5 до 3");
            return;
        }

        if (isNaN(r) || r < 1 || r > 4) {
            showNotification("Значение r должно быть в диапазоне от 1 до 4");
            return;
        }
        submitData(x, y, r);
    } catch (e) {
        console.log(e)
    }
};


function submitData(x, y, r) {
    console.log("Sending data to server...")
    console.log("here is url")

    const url = new URL(document.URL, window.location.href);
    console.log(url)
    url.searchParams.set('x', x);
    url.searchParams.set('y', y);
    url.searchParams.set('r', r);

    fetch(url, {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    })
        .then(response => response.json())
        .then(json => {
            json.serverTime = json.serverTime;
            json.executeTime = json.executeTime;
            updateResultsTable();
        })
        .catch(error => console.error('Error:', error));
    drawPoints(x, y, r);
}


function updateResultsTable() {
    fetch('jsp/table.jsp')
        .then(response => response.text())
        .then(html => {
            document.getElementById('results').innerHTML = html;
        })
        .catch(error => console.error('Ошибка при обновлении таблицы:', error));
}

function getResponsesFromLocalStorage() {
    let data = localStorage.getItem("data");
    if (data == null) {
        data = '[]';
    }
    const obj = JSON.parse(data);
    return Object.keys(obj).map((key) => obj[key]);
}

function saveResponseToLocalStorage(response, x, y, r) {
    let responses = getResponsesFromLocalStorage();
    response.x = x;
    response.y = y;
    response.r = r;
    responses.push(response);
    console.log('Responses:', responses);
    localStorage.setItem("data", JSON.stringify(responses));
}

function showResponse(response) {
    const resultBody = document.getElementById('result-table');
    const newRow = document.createElement('tr');

    newRow.innerHTML = `
        <td>${response.x !== undefined ? response.x : 'undefined'}</td>
        <td>${response.y !== undefined ? response.y : 'undefined'}</td>
        <td>${response.r !== undefined ? response.r : 'undefined'}</td>
        <td>${response.serverTime !== undefined ? response.serverTime : 'undefined'}</td>
        <td>${response.executionTime !== undefined ? response.executionTime : 'undefined'}</td>
        <td>${response.answer !== undefined ? (response.answer ? 'попал' : 'не попал') : 'undefined'}</td>
    `;

    resultBody.appendChild(newRow);
}


function init() {
    let data = getResponsesFromLocalStorage();
    for (let i = 0; i < data.length; i++) {
        console.log("Загрузка данных:", data[i]);
        showResponse(data[i]);
    }
}


function drawPoints(x, y, r) {
    const svg = document.querySelector('svg');
    const graphX = 150 + (x / r) * 100;
    const graphY = 150 - (y / r) * 100;

    const newDot = document.createElementNS("http://www.w3.org/2000/svg", "circle");
    newDot.setAttribute("cx", graphX);
    newDot.setAttribute("cy", graphY);
    newDot.setAttribute("r", 3);
    newDot.setAttribute("fill", "white");
    svg.appendChild(newDot);
}

window.onload = function() {
    console.log("init")
    init();
};


document.addEventListener("DOMContentLoaded", function () {
    const xBtns = document.querySelectorAll('.x-button');

    xBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            event.preventDefault()
            try {
                const selectedValue = parseFloat(btn.value);
                //console.log(selectedValue);
                xBtns.forEach(otherBtn => {
                    otherBtn.classList.remove('active');
                });
                if (selectedValue !== selectedXBtn && selectedValue.toString() === btn.value && validateSelection(selectedValue, xValidValues)) {
                    console.log("valid value")
                    console.log(selectedValue)
                    btn.classList.add('active');
                    selectedXBtn = selectedValue;
                } else {
                    btn.classList.remove('active');
                    selectedXBtn = null;
                }
            } catch (e) {
                console.log(e)
            }
        });
    });
});

function validateSelection(value, validValues) {
    return validValues.includes(value);
}