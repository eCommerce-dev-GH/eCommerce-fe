#!/bin/sh
# Server-side logic using Node.js with Express.js for an eCommerce website.

# First, make sure you have Node.js and npm installed on your system. Then, create a new directory for your project and initialize a new Node.js project:

mkdir ecommerce-website
cd ecommerce-website
npm init -y


# Next, install Express.js and other dependencies:

npm install express body-parser bcryptjs jsonwebtoken


# Now, let's create the server-side logic:

// app.js

const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());

// Simulated product data
const products = [
    { id: 1, name: 'Product 1', price: 20.99 },
    { id: 2, name: 'Product 2', price: 15.49 },
    { id: 3, name: 'Product 3', price: 30.00 },
    // Add more products as needed
];

// Route to get all products
app.get('/api/products', (req, res) => {
    res.json(products);
});

// Dummy user data for authentication
const users = [
    { id: 1, username: 'user1', password: '$2a$10$HLdf.tbygY4rqfntYIMsV.3ICZ6sId3tDdH7dHrE3eujLyP/wtMMm' } // Password is "password"
];

// Authentication route
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    const user = users.find(u => u.username === username);
    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }
    bcrypt.compare(password, user.password, (err, result) => {
        if (err || !result) {
            return res.status(401).json({ message: 'Invalid password' });
        }
        const token = jwt.sign({ username: user.username }, 'secretkey');
        res.json({ token });
    });
});

// Middleware for verifying JWT token
function verifyToken(req, res, next) {
    const token = req.headers['authorization'];
    if (!token) {
        return res.status(401).json({ message: 'Unauthorized' });
    }
    jwt.verify(token, 'secretkey', (err, decoded) => {
        if (err) {
            return res.status(401).json({ message: 'Unauthorized' });
        }
        req.user = decoded;
        next();
    });
}

// Protected route example
app.get('/api/user', verifyToken, (req, res) => {
    res.json({ message: 'Welcome ' + req.user.username });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});

