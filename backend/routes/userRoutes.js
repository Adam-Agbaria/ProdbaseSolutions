const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
// Routes for user management

// Middleware to validate user input for all post and put requests
router.use(['/', '/:id'], userController.validateInput);

// Route to create a new user
router.post('/', userController.createUser);

// Route to retrieve a user by its ID
router.get('/:id', userController.getUser);

// Route to update a user by its ID
router.put('/:id', userController.updateUser);

// Route to delete a user by its ID
router.delete('/:id', userController.deleteUser);

module.exports = router;
