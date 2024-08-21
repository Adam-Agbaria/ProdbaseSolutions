const express = require('express');
const router = express.Router();
const metricsController = require('../controllers/metricsController');

// Define the routes for metrics

// Route to add a new metrics entry for a day
router.post('/', metricsController.addMetricsForDay);

// Route to retrieve metrics for a specific date
router.get('/:date', metricsController.getMetricsForDate);

// Route to retrieve all metrics entries
router.get('/', metricsController.getAllMetrics);

// Route to increment a specific metric for a given day (this could be a PUT method too, based on use-case)
router.post('/increment', metricsController.incrementMetricForDate);

// Route to delete metrics for a specific date
router.delete('/:date', metricsController.deleteMetricsForDate);

module.exports = router;
