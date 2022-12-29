const table = document.querySelector("table.dataframe");
const th = [...table.querySelectorAll("thead th")];
const tr = [...table.querySelectorAll("tbody tr")];
const days = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam']
th.forEach(th => {
    const dt = new Date(th.textContent);
    th.classList.add(days[dt.getDay()]);
});
tr.forEach(tr => {
    const td = [...tr.querySelectorAll('td, th')];
    td.forEach((td, idx) => {
        th[idx].classList.forEach(classe => {
            if (days.includes(classe)) {
                td.classList.add(classe);
            }
        });
    });
});