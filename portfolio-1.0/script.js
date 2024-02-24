const menu = document.getElementById("menu-trigger");
const options = document.getElementById("menu-options");

menu.addEventListener('click', function() {
    if (options.style.transform == "translateX(0%)") {
        options.style.transform = "translateX(100%)";
    } else {
        options.style.transform = "translateX(0%)";
    }
});