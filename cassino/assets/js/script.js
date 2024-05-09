const navTrigger = document.getElementById("navTrigger");
const nav = document.getElementById("nav");
const barNav = document.querySelectorAll(".barNav");

if (window.innerWidth > 1200) {
    nav.style.translate = "0%";
}
function navToggle() {
    if (getComputedStyle(nav).translate == "-100%") {
        nav.style.translate = "0%";

        barNav[0].style.transition = ".3s";
        barNav[0].style.transformOrigin = "center";
        barNav[0].style.transform = "translateY(.1rem) rotate(-135deg)";
        
        barNav.initalMarginTop = ".6rem";
        barNav[1].style.transition = ".3s";
        barNav[1].style.marginTop = "0";
        barNav[1].style.transformOrigin = "center";
        barNav[1].style.transform = "translateY(-.1rem) rotate(135deg)";
    } else {
        nav.style.translate = "-100%";

        barNav[0].style.transform = "none";
        barNav[1].style.transform = "none";
        barNav[1].style.marginTop = barNav.initalMarginTop;
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