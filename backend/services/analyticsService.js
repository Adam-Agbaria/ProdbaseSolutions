const Product = require('../models/ProductModels');
const Client = require('../models/ClientModels');
const Transaction = require('../models/TransactionModels');
const Order = require('../models/OrderModels');
const Profit = require('../models/ProfitModels');

const createErrorObject = (errorType, errorMessage, extraInfo) => {
    return {
        errorType,
        errorMessage,
        extraInfo
    };
};

const analyticsService = {
    
    getTotalProfits: async (userId, startDate, endDate) => {
        try {
            const matchCondition = { user: userId };
    
            if (startDate && endDate) {
                matchCondition.profitDate = {
                    $gte: new Date(startDate),
                    $lte: new Date(endDate),
                };
            }
    
            const result = await Profit.aggregate([
                {
                    $match: matchCondition
                },
                {
                    $group: {
                        _id: null,
                        totalProfit: { $sum: "$profitAmount" }
                    }
                }
            ]);
    
            if (!result.length) {
                return { message: "You haven't made any profits yet." };
            }
    
            return result;
        } catch (error) {
            return createErrorObject('ProfitAnalyticsError', 'Failed to aggregate total profits', error);
        }
    },
    

    getTopProducts: async (userId) => {
        try {
            const result = await Order.aggregate([
                { $match: { user: userId } },
                { $unwind: "$products" },
                { $group: { _id: "$products.product", total: { $sum: "$products.quantity" } } },
                { $sort: { total: -1 } },
                { $limit: 5 },
                {
                    $lookup: {
                        from: "products",
                        localField: "_id",
                        foreignField: "_id",
                        as: "productInfo"
                    }
                }
            ]);

            if (!result.length) {
                return { message: "You haven't sold any products yet." };
            }

            return result;
        } catch (error) {
            return createErrorObject('ProductAnalyticsError', 'Failed to get top products', error);
        }
    },

    getTopClients: async (userId) => {
        try {
            const result = await Order.aggregate([
                { $match: { user: userId } },
                { $group: { _id: "$client", count: { $sum: 1 } } },
                { $sort: { count: -1 } },
                { $limit: 5 },
                {
                    $lookup: {
                        from: "clients",
                        localField: "_id",
                        foreignField: "_id",
                        as: "clientInfo"
                    }
                }
            ]);

            if (!result.length) {
                return { message: "You haven't made any sales to clients yet." };
            }

            return result;
        } catch (error) {
            return createErrorObject('ClientAnalyticsError', 'Failed to get top clients', error);
        }
    },

    getAverageOrderValue: async (userId) => {
        try {
            const result = await Order.aggregate([
                { $match: { user: userId } },
                {
                    $group: {
                        _id: null,
                        avgAmount: { $avg: "$totalAmount" }
                    }
                }
            ]);

            if (!result.length) {
                return { message: "You haven't made any sales yet." };
            }

            return result;
        } catch (error) {
            return createErrorObject('OrderAnalyticsError', 'Failed to get average order value', error);
        }
    },

    getOrderTrend: async (userId, startDate, endDate) => {
        try {
            const matchCondition = { user: userId };
    
            if (startDate && endDate) {
                matchCondition.orderDate = {
                    $gte: new Date(startDate),
                    $lte: new Date(endDate),
                };
            }
    
            const result = await Order.aggregate([
                {
                    $match: matchCondition
                },
                {
                    $group: {
                        _id: { $dateToString: { format: "%Y-%m-%d", date: "$orderDate" } },
                        count: { $sum: 1 }
                    }
                },
                { $sort: { "_id": 1 } }
            ]);
    
            if (!result.length) {
                return { message: "You haven't made any sales within this period." };
            }
    
            return result;
        } catch (error) {
            return createErrorObject('OrderAnalyticsError', 'Failed to get order trend', error);
        }
    },
    

    getTransactionTrend: async (userId, startDate, endDate) => {
        try {
            const result = await Transaction.aggregate([
                {
                    $match: {
                        user: userId,
                        transactionDate: {
                            $gte: new Date(startDate),
                            $lte: new Date(endDate)
                        }
                    }
                },
                {
                    $group: {
                        _id: { $dateToString: { format: "%Y-%m-%d", date: "$transactionDate" } },
                        count: { $sum: 1 }
                    }
                },
                { $sort: { "_id": 1 } }
            ]);

            if (!result.length) {
                return { message: "You haven't made any transactions within this period." };
            }

            return result;
        } catch (error) {
            return createErrorObject('TransactionAnalyticsError', 'Failed to get transaction trend', error);
        }
    }
};

module.exports = analyticsService;
