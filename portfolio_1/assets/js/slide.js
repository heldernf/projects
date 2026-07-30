const slideContainers = document.querySelectorAll(".slide-box");

slideContainers.forEach((container, index) => {
    let images = container.querySelectorAll("img");
    let buttons = container.querySelectorAll(".slide-button");
    let currentIndex = 0;

    function updateSlide() {
        // Garante que o índice não ultrapasse o número de imagens
        if (currentIndex >= images.length) currentIndex = 0;
        if (currentIndex < 0) currentIndex = images.length - 1;

        // Define a posição correta da primeira imagem no slide
        let offset = -100 * currentIndex;
        images[0].style.marginLeft = `${offset}%`;

        // Atualiza os botões de navegação
        buttons.forEach(btn => btn.style.backgroundColor = "transparent");
        if (buttons[currentIndex]) {
            buttons[currentIndex].style.backgroundColor = "white";
        }
    }

    function nextSlide() {
        currentIndex++;
        updateSlide();
    }

    function prevSlide() {
        currentIndex--;
        updateSlide();
    }

    // Botões manuais
    buttons.forEach((btn, btnIndex) => {
        btn.addEventListener("click", () => {
            currentIndex = btnIndex;
            updateSlide();
        });
    });

    // Auto slide
    setInterval(nextSlide, 8000);

    // Suporte a touch (mobile)
    let startX = 0, deltaX = 0;
    
    container.addEventListener("touchstart", e => {
        startX = e.touches[0].clientX;
    }, { passive: true });

    container.addEventListener("touchmove", e => {
        deltaX = e.touches[0].clientX - startX;
    }, { passive: true });

    container.addEventListener("touchend", () => {
        if (deltaX < -50) nextSlide(); // Arrastar para esquerda -> próxima imagem
        if (deltaX > 50) prevSlide(); // Arrastar para direita -> imagem anterior
    });
});