const entrarBtn = document.getElementById("entrarOption");
const registrarBtn = document.getElementById("registrarOption");
const modal = document.getElementById("modalContainer");
const inputs = document.querySelectorAll(".inputs");
const recoverPass = document.getElementById("esqueciSenha");
const criarConta = document.getElementById("pCriarConta");
const h2Modal = document.getElementById("h2Modal");
const closeModalBtn = document.getElementById("closeModal");
const h2OriginalInnerHTML = h2Modal.originalInnerHTML = h2Modal.innerHTML;;

function modalToggle(type) {
    if (type == "entrar") { 
        inputs[2].style.display = "none";
        inputs[3].style.display = "none";
        h2Modal.innerHTML = "Faça login em sua <span>conta</span>"
    } else {
        recoverPass.style.display = "none";
        criarConta.style.display = "none";
        h2Modal.innerHTML = h2OriginalInnerHTML;
    }

    modal.style.display = "flex";

    modal.addEventListener("click", function(event) {
        if (event.target === this) {
            this.style.display = "none";
        }
    });

    closeModalBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });
}

entrarBtn.addEventListener("click", () => {
    modalToggle("entrar");
});
registrarBtn.addEventListener("click", () => {
    modalToggle();
});