const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Define the routes for authentication

// Route for user registration
router.post('/register', authController.register);

// Route for user login
router.post('/login', authController.login);

// Route for user logout
router.post('/logout', authController.logout);

// Route for sending verification code for password reset
router.post('/sendVerificationCode', authController.sendVerificationCode);

// Route for verifying code and changing password
router.post('/verifyAndChangePassword', authController.verifyAndChangePassword);

module.exports = router;
