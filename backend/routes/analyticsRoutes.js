const express = require('express');
const router = express.Router();
const analyticsController = require('../controllers/analyticsController');

// Define the routes for the analytics

// Route to get total profits between specific dates
router.get('/total-profits/:userId', analyticsController.getTotalProfits);

// Route to get top products
router.get('/top-products/:userId', analyticsController.getTopProducts);

// Route to get top clients
router.get('/top-clients/:userId', analyticsController.getTopClients);

// Route to get average order value
router.get('/average-order-value/:userId', analyticsController.getAverageOrderValue);

// Route to get order trend between specific dates
router.get('/order-trend/:userId', analyticsController.getOrderTrend);

// Route to get transaction trend between specific dates
router.get('/transaction-trend/:userId', analyticsController.getTransactionTrend);

module.exports = router;
