const menuIcon = document.getElementById("menu-trigger");
const optionsBox = document.getElementById("menu-options");
const options = document.querySelectorAll(".options");
const main = document.querySelector("main");
const active = document.getElementById("active");
const sections = document.querySelectorAll("section");

// ABRE E FECHA
function toggleMenu() {
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
    option.addEventListener('click', function() {
        toggleMenu();
        activeOption(index);
    });
});

// FECHA O MENU QUANDO CLICA NO MAIN
main.addEventListener('click', function(){
    if (optionsBox.classList.contains('visible')) {
        toggleMenu();
    }
});

// ATUALIZA O LINK DO MENU QUE ESTÁ ATIVO
function tst () {
    sections.forEach((section, index) => {
        let topo = section.getBoundingClientRect().top;
        let janela = window.innerHeight;
    
        if (topo < janela) {
            activeOption(index);
            window.removeEventListener('scroll', tst);
        }
    });
}
window.addEventListener('scroll', tst);

// PASSAR IMAGENS AUTOMATICAMENTE (SLIDEPT1)
const firstImg = document.querySelectorAll(".first-img-slide");
const btnSlide = document.querySelectorAll(".slide-button");
const totalImg = 12;
let pSlide = 1;

function activeBackground() {
    for (let i = 0; i < totalImg; i++) {
        btnSlide[i].style.backgroundColor = "transparent";
    }

    if (pSlide == 0) {
        btnSlide[0].style.backgroundColor = "white"
        btnSlide[3].style.backgroundColor = "white"
        btnSlide[6].style.backgroundColor = "white"
        btnSlide[9].style.backgroundColor = "white"
    } else if (pSlide == 1) {
        btnSlide[1].style.backgroundColor = "white"
        btnSlide[4].style.backgroundColor = "white"
        btnSlide[7].style.backgroundColor = "white"
        btnSlide[10].style.backgroundColor = "white"
    } else if (pSlide == 2) {
        btnSlide[2].style.backgroundColor = "white"
        btnSlide[5].style.backgroundColor = "white"
        btnSlide[8].style.backgroundColor = "white"
        btnSlide[11].style.backgroundColor = "white"
    }
}

function moveSlide() {
    switch (pSlide) {
        case 0:
            firstImg.forEach(img => {
                img.style.marginLeft = "0%";
            })
            activeBackground();
            pSlide++;
            break;
        case 1:
            firstImg.forEach(img => {
                img.style.marginLeft = "-100%";
            })
            activeBackground();
            pSlide++;
            break;
        case 2:
            firstImg.forEach(img => {
                img.style.marginLeft = "-200%";
            })
            activeBackground();
            pSlide = 0;
            break;
    }
}

setInterval(function () {
    moveSlide();
}, 3000)

// PASSAR IMAGENS DO SLIDE CLeICANDO (SLIDE PT2)
btnSlide.forEach((button, index) => {
    button.addEventListener('click', function () {
        pSlide = index % 3;
        moveSlide();
        console.log(index, pSlide)
    });
});