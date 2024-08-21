const {
    ProfitCreationError,
    ProfitsByUserNotFoundError,
    ProfitByIdNotFoundError,
    ProfitUpdateError,
    ProfitDeletionError,
    ProfitsByProductNotFoundError,
    ProfitsByClientNotFoundError
} = require('../middleware/customErrors');
const Profit = require('../models/ProfitModels');

const profitService = {

    createProfit: async (userId, data) => {
        try {
            data.user = userId;
            const profit = new Profit(data);
            await profit.save();
            return profit;
        } catch (error) {
            throw new ProfitCreationError();
        }
    },

    getProfitById: async (userId, profitId) => {
        try {
            const profit = await Profit.findOne({ _id: profitId, user: userId }).populate('user').populate('order').populate('products.product').populate('client');
            if (!profit) {
                throw new ProfitByIdNotFoundError(profitId);
            }
            return profit;
        } catch (error) {
            if (error instanceof ProfitByIdNotFoundError) {
                throw error;
            }
            throw new Error(`Error fetching profit: ${error.message}`);
        }
    },

    getProfitsByUser: async (userId) => {
        try {
            const profits = await Profit.find({ user: userId }).populate('order').populate('products.product').populate('client');
            if (!profits || profits.length === 0) {
                throw new ProfitsByUserNotFoundError(userId);
            }
            return profits;
        } catch (error) {
            if (error instanceof ProfitsByUserNotFoundError) {
                throw error;
            }
            throw new Error(`Error fetching profits for user: ${error.message}`);
        }
    },

    updateProfit: async (userId, profitId, data) => {
        try {
            return await Profit.findOneAndUpdate({ _id: profitId, user: userId }, data, { new: true });
        } catch (error) {
            throw new ProfitUpdateError(profitId);
        }
    },

    deleteProfit: async (userId, profitId) => {
        try {
            await Profit.findOneAndDelete({ _id: profitId, user: userId });
        } catch (error) {
            throw new ProfitDeletionError(profitId);
        }
    },

    getProfitsByProduct: async (userId, productId) => {
        try {
            const profits = await Profit.find({ user: userId, "products.product": productId }).populate('user').populate('order').populate('products.product').populate('client');
            if (!profits || profits.length === 0) {
                throw new ProfitsByProductNotFoundError(productId);
            }
            return profits;
        } catch (error) {
            if (error instanceof ProfitsByProductNotFoundError) {
                throw error;
            }
            throw new Error(`Error fetching profits for product: ${error.message}`);
        }
    },

    getProfitsByClient: async (userId, clientId) => {
        try {
            const profits = await Profit.find({ user: userId, client: clientId }).populate('user').populate('order').populate('products.product');
            if (!profits || profits.length === 0) {
                throw new ProfitsByClientNotFoundError(clientId);
            }
            return profits;
        } catch (error) {
            if (error instanceof ProfitsByClientNotFoundError) {
                throw error;
            }
            throw new Error(`Error fetching profits for client: ${error.message}`);
        }
    }
};

module.exports = profitService;
