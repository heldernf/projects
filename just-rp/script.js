const ulMenu = document.getElementById('ulMenu');
const aMenu = document.querySelectorAll('.aMenu')
const first_aMenu = aMenu[0];
var WIDTH_BROWSER = window.innerWidth;
first_aMenu.classList.add('decorationLinkSelected');

// 
resizeBrowser();
function resizeBrowser() {
    WIDTH_BROWSER = window.innerWidth;

    if (WIDTH_BROWSER >= 992) {
        ulMenu.style.transform = 'scale(1)';
    } else {
        ulMenu.style.transform = 'scale(0)';
    }
}
window.addEventListener('resize', resizeBrowser)

// MOSTRA E OCULTA OS ITENS DO MENU
function menuDrop(aSelecionado) {
    if (WIDTH_BROWSER < 992) {
        if (ulMenu.style.transform == 'scale(1)') {
            ulMenu.style.transform = 'scale(0)';
        } else {
            ulMenu.style.transform = 'scale(1)';
        }
    } else {
        if (aSelecionado != undefined) {
            aMenu.forEach(function (a) {
                a.classList.remove('decorationLinkSelected');
            })
    
            aSelecionado.classList.add('decorationLinkSelected');
        }
    }
}

// FECHA O MENU QUANDO CLICA EM UMA OPÇÃO DELE
aMenu.forEach(function (aSelecionado) {
    aSelecionado.addEventListener('click', function () {
        menuDrop(aSelecionado);
    });
});

// FECHA O MENU QUANDO CLICA FORA DELE
function closeMenuDropClickMain() {
    if (ulMenu.style.transform == 'scale(1)') {
        menuDrop()
    }
}


// PASSA OS SLIDE DA SEÇÃO VIP
var icarro = 1;
var imoto = 1;
var ivip = 1;
var ioutro = 1;
var max = 3; // QUANTIDADE DE IMAGENS DO SLIDE

function passarSlide(labelClicado, controleIndex) {
    if (controleIndex == 0) {
        icarro = labelClicado;
        document.getElementById('slideCarro' + icarro).checked = true;
    } else if (controleIndex == undefined) {
        if (icarro == max) {
            icarro = 0;
        }
        icarro++;
        document.getElementById('slideCarro' + icarro).checked = true;
    }

    if (controleIndex == 1) {
        imoto = labelClicado;
        document.getElementById('slideMoto' + imoto).checked = true;
    } else if (controleIndex == undefined) {
        if (imoto == max) {
            imoto = 0;
        }
        imoto++;
        document.getElementById('slideMoto' + imoto).checked = true;
    }

    if (controleIndex == 2) {
        ivip = labelClicado;
        document.getElementById('slideVip' + ivip).checked = true;
    } else if (controleIndex == undefined) {
        if (ivip == max) {
            ivip = 0;
        }
        ivip++;
        document.getElementById('slideVip' + ivip).checked = true;
    }

    if (controleIndex == 3) {
        ioutro = labelClicado;
        document.getElementById('slideOutro' + ioutro).checked = true;
    } else if (controleIndex == undefined) {
        if (ioutro == max) {
            ioutro = 0;
        }
        ioutro++;
        document.getElementById('slideOutro' + ioutro).checked = true;
    }
}

setInterval(function () {
    passarSlide();
}, 7000);

const controlesSlide = document.querySelectorAll(".controleSlide");
controlesSlide.forEach(function (controleSlide, controleIndex) {
    const labels = controleSlide.querySelectorAll("label");

    labels.forEach(function (label, labelIndex) {
        label.addEventListener('click', function () {
            passarSlide(labelIndex + 1, controleIndex);
        });
    });
});


// ATUALIZA A DATA DOS DIREITOS AUTORAIS
const pCopyright = document.getElementById('copyright');
var anoAtual = new Date().getFullYear();
pCopyright.innerHTML = `&copy ${anoAtual} JUST, All rights reserved.`