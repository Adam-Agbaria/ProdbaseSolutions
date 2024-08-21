const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

// Define the routes for orders

// Route to create a new order
router.post('/', orderController.createOrder);

// Route to retrieve an order by its ID
router.get('/:id', orderController.getOrderById);

// Route to retrieve all orders for a specific user
router.get('/user/:userId', orderController.getOrdersByUserId);

// Route to update an order by its ID
router.put('/:id', orderController.updateOrderById);

// Route to delete an order by its ID
router.delete('/:id', orderController.deleteOrderById);

// Route to retrieve all orders by their status
router.get('/status/:status', orderController.getOrdersByStatus);

// Route to retrieve all orders for a specific client
router.get('/client/:clientId', orderController.getOrdersByClientId);

// Route to change the delivery status of an order
router.put('/:id/delivery-status', orderController.updateDeliveryStatus);

module.exports = router;
