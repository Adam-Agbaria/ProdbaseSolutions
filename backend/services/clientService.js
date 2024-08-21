const { ClientCreationError, ClientNotFoundError, ClientUpdateError, ClientDeleteError } = require('../middleware/customErrors');
const Client = require('../models/ClientModels');

const clientService = {
    
    // Create a new client
    async createClient(ownerId, clientData) {
        try {
            if (!ownerId || !clientData) {
                throw new Error("Missing userId or client Data");
              }
            clientData.owner = ownerId; // Ensure the client is associated with the user
            const client = new Client(clientData);
            const savedClient = await client.save();
            return savedClient;
        } catch (error) {
            console.error("Error while creating client: ", error);
            throw new ClientCreationError();
        }
    },

    // Retrieve a client by its ID and owner ID
    async getClientById(ownerId, clientId) {
        try {
            const client = await Client.findById(clientId);
            if (client.owner.toString() !== ownerId) {
                throw new ClientNotFoundError();
            }
            return client;
        } catch (error) {
            throw new ClientNotFoundError();
        }
    },

    // Retrieve all clients for a specific user
    async getClientsByOwnerId(ownerId) {
        try {
            return await Client.find({ owner: ownerId });
        } catch (error) {
            throw new ClientNotFoundError();
        }
    },

    // Update a client by its ID and owner ID
    async updateClientById(ownerId, clientId, updateData) {
        try {
            const client = await Client.findById(clientId);
            if (client.owner.toString() !== ownerId) {
                throw new ClientNotFoundError();
            }
            return await Client.findByIdAndUpdate(clientId, updateData, { new: true });
        } catch (error) {
            throw new ClientUpdateError();
        }
    },

    // Delete a client by its ID and owner ID
    async deleteClientById(ownerId, clientId) {
        try {
            const client = await Client.findById(clientId);
            if (client.owner.toString() !== ownerId) {
                throw new ClientNotFoundError();
            }
            return await Client.findByIdAndDelete(clientId);
        } catch (error) {
            throw new ClientDeleteError();
        }
    }

};

module.exports = clientService;
