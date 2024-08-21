const express = require('express');
const router = express.Router();
const profitController = require('../controllers/profitController');

// Routes for profit

// Route to create a new profit entry
router.post('/', profitController.createProfit);

// Route to get profit by its ID
router.get('/:id', profitController.getProfitById);

// Route to get profits for a specific user
router.get('/user/:userId', profitController.getProfitsByUser);

// Route to update a profit entry by its ID
router.put('/:id', profitController.updateProfit);

// Route to delete a profit entry by its ID
router.delete('/:id', profitController.deleteProfit);

// Route to get profits by a product's ID
router.get('/product/:productId', profitController.getProfitsByProduct);

// Route to get profits by a client's ID
router.get('/client/:clientId', profitController.getProfitsByClient);

module.exports = router;
