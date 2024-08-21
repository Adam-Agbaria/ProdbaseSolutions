const express = require('express');
const router = express.Router();
const transactionController = require('../controllers/transactionController');
// Routes for transaction management

// Route to create a new transaction
router.post('/',  transactionController.createTransaction);

// Route to retrieve a transaction by its ID
router.get('/:id',  transactionController.getTransaction);

// Route to retrieve all transactions for a specific user
router.get('/user/:userId', transactionController.getTransactionsForUser);

// Route to update a transaction by its ID
router.put('/:id', transactionController.updateTransaction);

// Route to delete a transaction by its ID
router.delete('/:id', transactionController.deleteTransaction);

// Route to retrieve transactions by their status
router.get('/status/:status', transactionController.getTransactionsByStatus);

// Route to retrieve transactions for a specific client
router.get('/client/:clientId', transactionController.getTransactionsForClient);

module.exports = router;
