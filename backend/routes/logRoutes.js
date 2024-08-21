const express = require('express');
const router = express.Router();
const logController = require('../controllers/logContoller');

// Define the routes for logs

// Route to create a new log entry
router.post('/', logController.createLog);

// Route to retrieve all logs
router.get('/', logController.getAllLogs);

// Route to retrieve logs by their type
router.get('/type/:logType', logController.getLogsByType);

// Route to retrieve logs associated with a specific user
router.get('/user/:userId', logController.getLogsByUser);

// Route to retrieve logs by their module type
router.get('/module/:moduleType', logController.getLogsByModule);

// Route to delete a specific log entry using its ID
router.delete('/:logId', logController.deleteLog);

module.exports = router;
