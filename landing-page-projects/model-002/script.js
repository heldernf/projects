function menuDrop() {
    const ulMenu = document.getElementById('ulMenu')
    
    if (ulMenu.style.transform == 'scale(1)') {
        ulMenu.style.transform = 'scale(0)'
    } else {
        ulMenu.style.transform = 'scale(1)'
    }
}