const navTrigger = document.getElementById("navTrigger");
const nav = document.getElementById("nav");
const barNav = document.querySelectorAll(".barNav");
const h2Nav = document.querySelectorAll(".h2Nav");

// EXIBE E OCULTA O NAV
function navToggle() {
    if (getComputedStyle(nav).translate == "-100%") {
        nav.style.translate = "0%";
    } else {
        nav.style.translate = "-100%";
    }
}
navTrigger.addEventListener("click", navToggle);

// EXIBE E OCULTA OS BLOCOS DE OPÇÕES DO NAV
function h2ListToggle(nextSibling) {
    if (getComputedStyle(nextSibling).display !== "none") {
        nextSibling.style.display = "none";
    } else {
        nextSibling.style.display = nextSibling.originalDisplay;
    }
}
h2Nav.forEach(h2 => {
    const nextSibling = h2.nextElementSibling;
    nextSibling.originalDisplay = getComputedStyle(nextSibling).display;
    
    h2.addEventListener("click", () => {
        h2ListToggle(nextSibling);
    });
})

// EVITA O SCROLL PULAR PARA O BODY APÓS ESCROLAR O NAV 100% PARA CIMA OU PARA BAIXO
function scrollJump(event) {
    const delta = Math.sign(event.deltaY);
    if ((delta < 0 && nav.scrollTop == 0) || (delta > 0 && nav.scrollTop == nav.scrollHeight - nav.clientHeight)) {
        event.preventDefault();
    }
}
nav.addEventListener('wheel', (event) => {
    scrollJump(event);
});