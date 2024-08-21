const express = require('express');
const router = express.Router();
const settingsController = require('../controllers/settingsController');

// Routes for settings

// Route to create new settings for a user
router.post('/', settingsController.createSettings);

// Route to retrieve settings for a specific user (uses currently logged in user's ID from req.user._id)
router.get('/', settingsController.getSettingsByUser);

// Route to update settings for a specific user
router.put('/', settingsController.updateSettings);

// Route to delete settings for a specific user
router.delete('/', settingsController.deleteSettings);

module.exports = router;
