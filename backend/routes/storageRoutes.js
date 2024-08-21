const express = require('express');
const router = express.Router();
const storageController = require('../controllers/storageController');

// Middleware for file uploading (assuming you're using multer or a similar library)

// Routes for file storage

// Route to upload a file
router.post('/upload', storageController.uploadFile); // Assuming 'file' is the field name in your form

// Route to download a specific file
router.get('/files/:fileName', storageController.downloadFile);

// Route to delete a specific file
router.delete('/files/:fileName', storageController.removeFile);

module.exports = router;
