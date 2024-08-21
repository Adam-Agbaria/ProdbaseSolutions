const express = require('express');
const router = express.Router();
const clientController = require('../controllers/clientController');

// Define the routes for clients

// Route to create a new client
router.post('/', clientController.createClient);

// Route to retrieve a specific client using its ID
router.get('/:clientId', clientController.getClientById);

// Route to retrieve clients based on their owner's ID
router.get('/owner/:ownerId', clientController.getClientsByOwnerId);

// Route to update a client by its ID
router.put('/:clientId', clientController.updateClientById);

// Route to delete a client by its ID
router.delete('/:clientId', clientController.deleteClientById);

module.exports = router;
