const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');

// Routes for products

// Route to create a new product
router.post('/', productController.createProduct);

// Route to get all products
router.get('/', productController.getAllProducts);

// Route to get a product by its ID
router.get('/:id', productController.getProductById);

// Route to update a product by its ID
router.put('/:id', productController.updateProductById);

// Route to delete a product by its ID
router.delete('/:id', productController.deleteProductById);

// Route to get products by the owner's ID
router.get('/owner/:ownerId', productController.getProductsByOwnerId);

module.exports = router;
