const express = require('express');
const router = express.Router();
const tokenController = require('../controllers/tokenController');

// Routes for token management

// Route to generate a token for a user
router.post('/generate', tokenController.generateTokenForUser);

// Route to validate a token. This route is protected by the verifyToken middleware 
// to ensure that only a valid token can access this endpoint.
router.get('/validate', tokenController.validateToken);

// Route to refresh a user's token
router.post('/refresh', tokenController.refreshUserToken);  // Consider if you want to add the verifyToken middleware here too

module.exports = router;
