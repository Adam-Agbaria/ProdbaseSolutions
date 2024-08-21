const clientService = require('../services/clientService');

const clientController = {

    createClient: async (req, res, next) => {
        try {
            console.log(req.body);
            const clientData = req.body.ClientInfo;
            const userId = req.body.userId; // Assuming user ID is stored in req.user
            const newClient = await clientService.createClient(userId, clientData);
            return res.status(201).json({ success: true, message: "Client created successfully", data: newClient });
        } catch (error) {
            next(error);
        }
    },

    getClientById: async (req, res, next) => {
        try {
            const clientId = req.params.clientId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const client = await clientService.getClientById(userId, clientId);
            if (!client) {
                return res.status(404).json({ success: false, message: "Client not found" });
            }
            return res.status(200).json({ success: true, data: client });
        } catch (error) {
            next(error);
        }
    },

    getClientsByOwnerId: async (req, res, next) => {
        try {
            const userId = req.params.ownerId; // Assuming user ID is stored in req.user
            const clients = await clientService.getClientsByOwnerId(userId);
            return res.status(200).json({ success: true, data: clients });
        } catch (error) {
            next(error);
        }
    },

    updateClientById: async (req, res, next) => {
        try {
            const clientId = req.params.clientId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const updateData = req.body;
            const updatedClient = await clientService.updateClientById(userId, clientId, updateData);
            return res.status(200).json({ success: true, message: "Client updated successfully", data: updatedClient });
        } catch (error) {
            next(error);
        }
    },

    deleteClientById: async (req, res, next) => {
        try {
            const clientId = req.params.clientId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            await clientService.deleteClientById(userId, clientId);
            return res.status(200).json({ success: true, message: "Client deleted successfully" });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = clientController;
