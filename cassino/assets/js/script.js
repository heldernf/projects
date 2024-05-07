const navTrigger = document.getElementById("navTrigger");
const nav = document.getElementById("nav");

if (window.innerWidth > 1200) {
    nav.style.translate = "0%";
}
function navToggle() {
    if (getComputedStyle(nav).translate == "-100%") {
        nav.style.translate = "0%";
    } else {
        nav.style.translate = "-100%";
    }
}
navTrigger.addEventListener("click", navToggle);

const h2Nav = document.querySelectorAll(".h2Nav");
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