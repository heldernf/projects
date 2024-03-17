const menuIcon = document.getElementById("menu-trigger");
const optionsBox = document.getElementById("menu-options");
const options = document.querySelectorAll(".options");
const main = document.querySelector("main");
const active = document.getElementById("active");
const sections = document.querySelectorAll("section");

// NÃO DEIXA O MENU BUGAR SE ELE ESTIVER ABERTO E OCORRER UM resize para 600px e vice e verso
window.addEventListener('resize', function () {
    if (window.innerWidth == 600) {
        optionsBox.classList.remove('visible')
        optionsBox.classList.add('invisible')
        menuIcon.classList.remove('animeMenu')
    }
});

// ABRE E FECHA
function toggleMenu() {
    if (window.innerWidth < 600) {
        if (optionsBox.classList.contains('invisible')) {
            optionsBox.classList.remove('invisible');
            optionsBox.classList.add('visible');

            menuIcon.classList.add('animeMenu')
        } else {
            optionsBox.classList.remove('visible');
            optionsBox.classList.add('invisible');

            menuIcon.classList.remove('animeMenu')
        }
    }
}
menuIcon.addEventListener('click', toggleMenu);

// ADD UM ID ESTILIZADO COM UMA ANIMAÇÃO NO CSS PARA AS OPÇÕES DO MENU
function activeOption(index) {
    options.forEach(option => {
        option.removeAttribute('id');
    });

    options[index].id = 'active';
}

// FECHA O MENU QUANDO CLICA EM UMA DAS OPÇÕES DELE
options.forEach((option, index) => {
    option.addEventListener('click', function () {
        toggleMenu();
        activeOption(index);
    });
});

// FECHA O MENU QUANDO CLICA NO MAIN
main.addEventListener('click', function () {
    if (optionsBox.classList.contains('visible')) {
        toggleMenu();
    }
});

// ATUALIZA O LINK DO MENU QUE ESTÁ ATIVO
let timeout;
function attOption() {
    clearTimeout(timeout);
    timeout = setTimeout(function () {
        sections.forEach((section, index) => {
            let topo = section.getBoundingClientRect().top;
            let janela = window.innerHeight;

            if (topo < janela - 450) {
                activeOption(index);
            }
        });
    }, 200);
}
window.addEventListener('scroll', attOption);

// SLIDE FUNCTIONS ---- SLIDE FUNCTIONS ---- SLIDE FUNCTIONS
const firstImg = document.querySelectorAll(".first-img-slide");
const btnSlide = document.querySelectorAll(".slide-button");
const slideBox = document.getElementsByClassName("slide-box");
const totalImg = slideBox.length * slideBox[0].getElementsByTagName("img").length;
let positionSlide = 1;

function activeBackground() {
    btnSlide.forEach(btn => {
        btn.style.backgroundColor = "transparent";
    });
    for (let i = positionSlide; i < totalImg; i += 3) {
        btnSlide[i].style.backgroundColor = "white";
    }
}

// PASSA IMAGENS AUTOMATICAMENTE
function moveSlide() {
    switch (positionSlide) {
        case 0:
            firstImg.forEach(img => {
                img.style.marginLeft = "0%";
            })
            activeBackground();
            positionSlide++;
            break;
        case 1:
            firstImg.forEach(img => {
                img.style.marginLeft = "-100%";
            })
            activeBackground();
            positionSlide++;
            break;
        case 2:
            firstImg.forEach(img => {
                img.style.marginLeft = "-200%";
            })
            activeBackground();
            positionSlide = 0;
            break;
    }
}
const intervalo = setInterval(moveSlide, 10000);

// PASSA IMAGENS DO SLIDE CLICANDO
btnSlide.forEach((button, index) => {
    button.addEventListener('click', function () {         
        const img = button.parentNode.parentNode.getElementsByClassName("first-img-slide");
        const slideControls = button.parentNode.querySelectorAll(".slide-button");
        const positionSlideDois = index % 3;

        slideControls.forEach(control => {
            control.style.backgroundColor = "transparent"
        });

        if (positionSlideDois == 0) {
            img[0].style.marginLeft = "0%";
            btnSlide[index].style.backgroundColor = "white";
        } else if (positionSlideDois == 1) {
            img[0].style.marginLeft = "-100%";
            btnSlide[index].style.backgroundColor = "white";
        } else {
            img[0].style.marginLeft = "-200%";
            btnSlide[index].style.backgroundColor = "white";
        }
    });
});