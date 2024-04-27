#!/bin/sh
# this is eCommerce website in java format

// Simulated product data
const products = [
    { id: 1, name: 'Product 1', price: 20.99, image: 'product1.jpg' },
    { id: 2, name: 'Product 2', price: 15.49, image: 'product2.jpg' },
    { id: 3, name: 'Product 3', price: 30.00, image: 'product3.jpg' },
    // Add more products as needed
];

// Function to display products on the page
function displayProducts() {
    const productsContainer = document.getElementById('products');
    let productHTML = '';

    products.forEach(product => {
        productHTML += `
            <div class="product">
                <img src="images/${product.image}" alt="${product.name}">
                <h2>${product.name}</h2>
                <p>$${product.price}</p>
                <button>Add to Cart</button>
            </div>
        `;
    });

    productsContainer.innerHTML = productHTML;
}

// Call the function to display products when the page loads
window.onload = displayProducts;

