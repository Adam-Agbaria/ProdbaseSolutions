const ProfitService = require('../services/profitService');

const profitController = {

    // Create a new profit entry
    createProfit: async (req, res, next) => {
        try {
            const profitData = req.body;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const profit = await ProfitService.createProfit(userId, profitData);
            res.status(201).json({ success: true, data: profit });
        } catch (error) {
            next(error);
        }
    },

    // Get profit by ID
    getProfitById: async (req, res, next) => {
        try {
            const profitId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const profit = await ProfitService.getProfitById(userId, profitId);
            res.status(200).json({ success: true, data: profit });
        } catch (error) {
            next(error);
        }
    },

    // Get profits for the authenticated user
    getProfitsByUser: async (req, res, next) => {
        try {
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const profits = await ProfitService.getProfitsByUser(userId);
            res.status(200).json({ success: true, data: profits });
        } catch (error) {
            next(error);
        }
    },

    // Update a profit entry
    updateProfit: async (req, res, next) => {
        try {
            const profitId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const updatedData = req.body;
            const updatedProfit = await ProfitService.updateProfit(userId, profitId, updatedData);
            res.status(200).json({ success: true, data: updatedProfit });
        } catch (error) {
            next(error);
        }
    },

    // Delete a profit entry
    deleteProfit: async (req, res, next) => {
        try {
            const profitId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            await ProfitService.deleteProfit(userId, profitId);
            res.status(200).json({ success: true, message: 'Profit entry deleted successfully' });
        } catch (error) {
            next(error);
        }
    },

        // Get profits for a specific product
    getProfitsByProduct: async (req, res, next) => {
        try {
            const productId = req.params.productId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const profits = await ProfitService.getProfitsByProduct(userId, productId);
            res.status(200).json({ success: true, data: profits });
        } catch (error) {
            next(error);
        }
    },

    // Get profits for a specific client
    getProfitsByClient: async (req, res, next) => {
        try {
            const clientId = req.params.clientId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const profits = await ProfitService.getProfitsByClient(userId, clientId);
            res.status(200).json({ success: true, data: profits });
        } catch (error) {
            next(error);
        }
    }

};

module.exports = profitController;
