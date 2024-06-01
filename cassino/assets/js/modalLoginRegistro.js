const entrarBtn = document.getElementById("entrarOption");
const registrarBtn = document.getElementById("registrarOption");
const modalContainer = document.getElementById("modalContainer");
const modal = document.getElementById("modal");
const closeBtn = document.getElementById("closeModal");

const h2 = document.getElementById("h2Modal");
h2.originalHTML = h2.innerHTML;

const inputs = document.querySelectorAll(".inputs");
inputs[0].originalDisplay = getComputedStyle(inputs[0]).display;
inputs[1].originalDisplay = getComputedStyle(inputs[1]).display;

const esqueciSenha = document.getElementById("esqueciSenha");

const btnConfirmEntrarRegistrar = document.getElementById("logarRegistrar");
btnConfirmEntrarRegistrar.originalText = btnConfirmEntrarRegistrar.innerHTML;

const pCriarEntrar = document.getElementById("pCriarEntrar");
pCriarEntrar.originalHTML = pCriarEntrar.innerHTML;
let btnCriarEntrar = document.getElementById("btnCriarEntrar");

modal.originalAnimation = getComputedStyle(modal).animation;
modal.animationDurationMs = Number(getComputedStyle(modal).animationDuration.replace("s", "")) * 1000;

let entrando = false;

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= //

// FUNÇÃO PARA TROCAR ENTRE ENTRAR/REGISTRAR QUANDO O MODAL ESTÁ ABERTO
function modalTroca() {
    const styleSheet = document.createElement("style");
    document.head.appendChild(styleSheet);

    styleSheet.innerHTML = `
    @keyframes troca {
        50% {
            opacity: 0;
            transform: scale(0);
        }
        
        100% {
            opacity: 1;
            transform: scale(1);
        }
    }`;
    modal.style.animation = "troca .6s ease-in-out 1";
    setTimeout(() => {
        if (entrando) {
            entrando = false;
            typeModal();
        } else {
            entrando = true;
            typeModal("entrar");
        }
    }, Number(getComputedStyle(modal).animationDuration.replace("s", "")) * 1000 / 2);

    setTimeout(() => {
        modal.style.animation = "none";
    }, Number(getComputedStyle(modal).animationDuration.replace("s", "")) * 1000);
}

// TRATA OS ELEMENTOS QUE DEVEM SER ESCONDIDOS NO MODAL DE ACORDO COM O 'type'
function typeModal(type) {
    if (type == "entrar") {
        entrando = true;

        h2.innerHTML = `Faça login em sua <${h2.children[0].tagName.toLowerCase()}>conta</${h2.children[0].tagName.toLowerCase()}>`
        // CAMPO DO NOME
        inputs[0].style.display = "none";
        // CAMPO DO CPF
        inputs[1].style.display = "none";
        btnConfirmEntrarRegistrar.textContent = "Entrar";
        pCriarEntrar.innerHTML = `Não tem uma conta? <span id=\"${btnCriarEntrar.id}\">Criar uma conta</span>`;
        
        btnCriarEntrar = document.getElementById("btnCriarEntrar");
        btnCriarEntrar.addEventListener("click", modalTroca);
    } else {
        h2.innerHTML = h2.originalHTML;
        // CAMPO DO NOME
        inputs[0].style.display = inputs[0].originalDisplay;
        // CAMPO DO CPF
        inputs[1].style.display = inputs[1].originalDisplay;
        esqueciSenha.style.display = "none";
        btnConfirmEntrarRegistrar.textContent = btnConfirmEntrarRegistrar.originalText;
        pCriarEntrar.innerHTML = pCriarEntrar.originalHTML;

        btnCriarEntrar = document.getElementById("btnCriarEntrar");
        btnCriarEntrar.addEventListener("click", modalTroca);
    }
}

// TRAVA PARA EVITAR CHAMADAS REPITIDAS QUANDO O MODAL TIVER FECHANDO
let running = false;
// FUNÇÃO PARA FECHAR E ABRIR O MODAL
function modalToggle(type) {
    if (getComputedStyle(modalContainer).display == "none") {
        // EXIBE O MODAL
        typeModal(type);
        modalContainer.style.display = "flex";
    } else {
        running = true;

        // RESETA O 'animation'
        modal.style.animation = "none";

        // TIMEOUT PARA FUNCIONAR POIS SE NÃO COLOCAR NÃO DA CERTO JA QUE TUDO
        // OCORRE DE FORMA MUITO RÁPIDA NO JS
        setTimeout(() => {
            // MONTA A 'animation' NOVAMENTE PORÉM AGORA COM A DIREÇÃO 'reverse'
            modal.style.animation = modal.originalAnimation;
            modal.style.animationDirection = "reverse";

            // ESCONDE O MODAL E RESETA A 'animation' PARA O PADRÃO DELA DE
            // ACORDO COM O CSS DA MESMA. O TEMPO É BASEADO EM QUANTO DURA
            // ANIMAÇÃO DO MODAL NO CSS
            setTimeout(() => {
                modalContainer.style.display = "none";
                modal.style.animation = modal.originalAnimation;

                running = false;
            }, modal.animationDurationMs);
        }, 1);
    }
}

// ABRE MODAL DE ENTRAR
entrarBtn.addEventListener("click", () => {
    modalToggle("entrar");
});

// ABRE MODAL DE REGISTRO
registrarBtn.addEventListener("click", () => {
    modalToggle();
});

// FECHA MODAL
modalContainer.addEventListener("click", function (event) {
    if (running == false) {
        if (event.target === this) {
            modalToggle();
        }
    }
});

// FECHA MODAL
closeBtn.addEventListener("click", () => {
    if (running == false) {
        modalToggle();
    }
});