const analyticsService = require('../services/analyticsService');
const logger = require('../utils/logger'); // Assuming you have a logger utility

const analyticsController = {

    getTotalProfits: async (req, res) => {
        try {
            const { startDate, endDate } = req.query;
            const userId = req.params.userId; // Assuming user ID is stored in req.user
            const result = await analyticsService.getTotalProfits(userId, startDate, endDate);
            return res.status(200).json(result);
        } catch (error) {
            logger.error(`Error fetching total profits: ${error.message}`);
            return res.status(500).json({ message: "An error occurred while fetching total profits." });
        }
    },

    getTopProducts: async (req, res) => {
        try {
            const userId = req.params.userId;
            const result = await analyticsService.getTopProducts(userId);
            return res.status(200).json(result);
        } catch (error) {
            logger.error(`Error fetching top products: ${error.message}`);
            return res.status(500).json({ message: "An error occurred while fetching top products." });
        }
    },

    getTopClients: async (req, res) => {
        try {
            const userId = req.params.userId;
            const result = await analyticsService.getTopClients(userId);
            return res.status(200).json(result);
        } catch (error) {
            logger.error(`Error fetching top clients: ${error.message}`);
            return res.status(500).json({ message: "An error occurred while fetching top clients." });
        }
    },

    getAverageOrderValue: async (req, res) => {
        try {
            const userId = req.params.userId;
            const result = await analyticsService.getAverageOrderValue(userId);
            return res.status(200).json(result);
        } catch (error) {
            logger.error(`Error fetching average order value: ${error.message}`);
            return res.status(500).json({ message: "An error occurred while fetching average order value." });
        }
    },

    getOrderTrend: async (req, res) => {
        try {
            const { startDate, endDate } = req.query;
            const userId = req.params.userId;
            const result = await analyticsService.getOrderTrend(userId, startDate, endDate);
            return res.status(200).json(result);
        } catch (error) {
            logger.error(`Error fetching order trend: ${error.message}`);
            return res.status(500).json({ message: "An error occurred while fetching order trend." });
        }
    },

    getTransactionTrend: async (req, res) => {
        try {
            const { startDate, endDate } = req.query;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const result = await analyticsService.getTransactionTrend(userId, startDate, endDate);
            return res.status(200).json(result);
        } catch (error) {
            logger.error(`Error fetching transaction trend: ${error.message}`);
            return res.status(500).json({ message: "An error occurred while fetching transaction trend." });
        }
    }
};

module.exports = analyticsController;
