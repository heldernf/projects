// SISTEMA DE BUSCA, ADICIONA ESTILO AO FILTROS

const searchInput = document.querySelector('#search-bar');
const searchButton = document.querySelector('#search-button');
let platformFilter = 'all';

searchButton.addEventListener('click', () => {
  const searchValue = searchInput.value.trim().toLowerCase();

  document.querySelectorAll('.container-product').forEach(container => {
    const productText = container.querySelector('p:first-of-type').textContent.toLowerCase();
    const platformText = container.querySelector('p.description-product').textContent.toLowerCase();

    if ((platformFilter === 'all' || platformText.includes(platformFilter)) && productText.includes(searchValue)) {
      container.style.display = '';
    } else {
      container.style.display = 'none';
    }
  });
});

const navLinks = document.querySelectorAll('nav ul li a');

navLinks.forEach(link => {
  link.addEventListener('click', event => {
    event.preventDefault();

    navLinks.forEach(navLink => {
      navLink.classList.remove('active');
    });

    link.classList.add('active');

    platformFilter = link.getAttribute('data-platform');

    document.querySelectorAll('.container-product').forEach(container => {
      const productText = container.querySelector('p:first-of-type').textContent.toLowerCase();
      const platformText = container.querySelector('p.description-product').textContent.toLowerCase();

      if ((platformFilter === 'all' || platformText.includes(platformFilter)) && productText.includes(searchInput.value.trim().toLowerCase())) {
        container.style.display = '';
      } else {
        container.style.display = 'none';
      }
    });
  });
});

searchInput.addEventListener('keydown', event => {
  if (event.keyCode === 13) {
    event.preventDefault();

    const searchValue = searchInput.value.trim().toLowerCase();

    document.querySelectorAll('.container-product').forEach(container => {
      const productText = container.querySelector('p:first-of-type').textContent.toLowerCase();
      const platformText = container.querySelector('p.description-product').textContent.toLowerCase();

      if ((platformFilter === 'all' || platformText.includes(platformFilter)) && productText.includes(searchValue)) {
        container.style.display = '';
      } else {
        container.style.display = 'none';
      }
    });
  }
});

// MOSTRA E OCULTA OS FILTROS (nav ul li)

var btn_filter = document.querySelector('#show-or-hide-btn');
var option_filter = document.querySelectorAll('nav ul li');

for (var i = 0; i < option_filter.length; i++) {
  option_filter[i].style.opacity = 0;
  option_filter[i].style.display = 'none';
  option_filter[i].style.height = 0;
  option_filter[i].style.transition = 'opacity 0.3s ease-in-out, height 0.3s ease-in-out';
}

btn_filter.addEventListener('click', function() {
  for (var i = 0; i < option_filter.length; i++) {
    if (option_filter[i].style.opacity == "0") {
      option_filter[i].style.display = 'flex';
      option_filter[i].style.height = 'auto';
      setTimeout((function(i) {
        option_filter[i].style.opacity = 1;
      }).bind(null, i), 50);
    } else {
      option_filter[i].style.opacity = 0;
      option_filter[i].style.height = 0;
      setTimeout((function(i) {
        option_filter[i].style.display = 'none';
      }).bind(null, i), 300);
    }
  }
});

// EMBARALHA TODOS OS PRODUTOS (product-container)

const productsContainer = document.getElementById("products-container");
const containerProducts = productsContainer.querySelectorAll(".container-product");
const containerProductsArray = Array.from(containerProducts);

containerProductsArray.sort(() => Math.random() - 0.5);

containerProductsArray.forEach(containerProduct => {
  productsContainer.appendChild(containerProduct);
});

// SCROLLBAR

$(document).ready(function() {
  $('#content').overlayScrollbars({
    className: "os-theme-dark",
    resize: "none"
  });
});