const express = require('express');
const router = express.Router();
const recoveryController = require('../controllers/recoveryController');

// Routes for recovery

// Route to trigger a backup for the current database state
router.post('/backup', recoveryController.backupCurrentState);

// Route to restore the database from a backup
router.post('/recover/:backupId', recoveryController.recoverFromBackup);

// Route to clear the database - BE CAREFUL WITH THIS IN PRODUCTION
router.delete('/clear', recoveryController.clearDatabase);

module.exports = router;
