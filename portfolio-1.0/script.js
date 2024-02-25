// ABRIR E FECHAR MENU
const menu = document.getElementById("menu-trigger");
const options = document.getElementById("menu-options");
menu.addEventListener('click', function () {
    if (options.style.transform == "translateX(0%)") {
        options.style.transform = "translateX(100%)";
    } else {
        options.style.transform = "translateX(0%)";
    }
});

// PASSAR IMAGENS DO SLIDE CLICANDO
const imgSlide = document.getElementById("first-img-slide");
const slideControl = document.querySelectorAll(".slide-button");
let i = 0;
slideControl.forEach(button => {
    button.addEventListener('click', function () {
        if (button === slideControl[0]) {
            imgSlide.style.marginLeft = "0%";
            i = 2;
            
            slideControl[0].style.backgroundColor = "white";
            slideControl[1].style.backgroundColor = "transparent";
            slideControl[2].style.backgroundColor = "transparent";
        } else if (button === slideControl[1]) {
            imgSlide.style.marginLeft = "-100%";
            i = 3;
            
            slideControl[0].style.backgroundColor = "transparent";
            slideControl[1].style.backgroundColor = "white";
            slideControl[2].style.backgroundColor = "transparent";
        } else {
            imgSlide.style.marginLeft = "-200%";
            i = 1;
            
            slideControl[0].style.backgroundColor = "transparent";
            slideControl[1].style.backgroundColor = "transparent";
            slideControl[2].style.backgroundColor = "white";
        }
    })
})

// PASSAR IMAGENS AUTOMATICAMENTE
setInterval(function () {
    switch (i) {
        case 1:
            imgSlide.style.marginLeft = "-0%";
            slideControl[2].style.backgroundColor = "transparent";
            slideControl[0].style.backgroundColor = "white";
            i++;
            break;
        case 2:
            imgSlide.style.marginLeft = "-100%";
            slideControl[0].style.backgroundColor = "transparent";
            slideControl[1].style.backgroundColor = "white";
            i++;
            break;
        case 3:
            imgSlide.style.marginLeft = "-200%";
            slideControl[1].style.backgroundColor = "transparent";
            slideControl[2].style.backgroundColor = "white";
            i = 1;
            break;
        default:
            imgSlide.style.marginLeft = "-100%";
            slideControl[0].style.backgroundColor = "transparent";
            slideControl[1].style.backgroundColor = "white";
            i = 3;
    }
}, 3000)