const express = require('express');
const router = express.Router();
const backupController = require('../controllers/backupController');

// Define the routes for backups

// 1. Route to create a new backup record
router.post('/', backupController.createBackup);

// 2. Route to retrieve all backups for a specific user
router.get('/user/:userId', backupController.getAllBackupsByUser);

// 3. Route to retrieve a specific backup using its ID
router.get('/:backupId', backupController.getBackupById);

// 4. Route to update the status of a backup
router.put('/:backupId/status', backupController.updateBackupStatus);

// 5. Route to delete a backup record
router.delete('/:backupId', backupController.deleteBackup);

module.exports = router;
