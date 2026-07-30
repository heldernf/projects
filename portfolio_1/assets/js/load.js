function load() {
    const body = document.querySelector("body");
    const div = document.createElement("div");
    
    body.appendChild(div);
    body.style.overflow = 'hidden';
    div.classList.add('load');
}
document.getElementById("form-contato").addEventListener("submit", load);