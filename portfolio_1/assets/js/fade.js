const fadeElements = document.querySelectorAll(".fade-up, .fade-right, .fade-down, .fade-left, .fade-boom");
let counter = 0;
window.innerWidth < 500 ? lack = 650 : lack = 750;

function stopEventListenerScroll() {
    window.removeEventListener("scroll", fade);
}

function delaySet(fade) {
    const regex = /fade-delay-(\d+(_\d+)?s)/;
    
    for (let cls of fade.classList) {
        const search = regex.exec(cls);
        if (search) {
            return search[1].replace('_', '.');
        }
    }

    return '0s';
}

function fade() {
    fadeElements.forEach(fade => {        
        if (fade.getBoundingClientRect().top - document.querySelector("header").offsetHeight <= lack) {
            const delay = delaySet(fade);
            fade.style.transition = `1s cubic-bezier(0.25, 1, 0.5, 1) ${delay}`;
            fade.classList.contains("fade-boom") ? fade.style.scale = "1"  : fade.style.translate = "0 0";
            fade.style.opacity = '1';
        }
    });
}
window.addEventListener("scroll", fade);
document.addEventListener("DOMContentLoaded", fade);