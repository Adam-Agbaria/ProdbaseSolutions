const { TransactionCreationError, TransactionUpdateError, TransactionNotFoundError, TransactionDeleteError } = require('../middleware/customErrors');
const Transaction = require('../models/TransactionModels');
const helpers = require('../utils/helpers');

const transactionService = {

    // Create a new transaction
    async createTransaction(userId, transactionData) {
        try {
             // Make sure userId and productData are not null or undefined
            if (!userId || !transactionData) {
                throw new Error("Missing userId or productData");
            }
            // Convert the strings back to your enum representation
            transactionData.paymentMethod = helpers.stringToPaymentMethod(transactionData.paymentMethod);
            transactionData.status = helpers.stringToTransactionStatus(transactionData.status);

            transactionData.user = userId;
            const transaction = new Transaction(transactionData);

            const savedTransaction = await transaction.save();

            return savedTransaction;
        } catch (error) {
            console.error("Error while creating transaction: ", error);
            throw TransactionCreationError();
        }
    },

    // Retrieve a transaction by its ID
    async getTransactionById(userId, transactionId) {
        try {
            return await Transaction.findOne({ _id: transactionId, user: userId })
                                     .populate('user')
                                     .populate('client')
                                     .populate('product')
                                     .populate('order');
        } catch (error) {
            throw new TransactionUpdateError();
        }
    },

    // Retrieve all transactions for a specific user
    async getTransactionsByUserId(userId) {
        try {
            if (!userId) {
                throw new Error("Missing userId or productData");
              }
            return await Transaction.find({ user: userId });
                                    //  .populate('client')
                                    //  .populate('product')
                                    //  .populate('order');
        } catch (error) {
            throw new TransactionNotFoundError();
        }
    },

    // Update a transaction by its ID
    async updateTransactionById(userId, transactionId, updateData) {
        try {
            return await Transaction.findOneAndUpdate({ _id: transactionId, user: userId }, updateData, { new: true })
                                     .populate('user')
                                     .populate('client')
                                     .populate('product')
                                     .populate('order');
        } catch (error) {
            throw new TransactionUpdateError();
        }
    },

    // Delete a transaction by its ID
    async deleteTransactionById(userId, transactionId) {
        try {
            return await Transaction.findOneAndDelete({ _id: transactionId, user: userId });
        } catch (error) {
            throw new TransactionDeleteError();
        }
    },

    // Retrieve all transactions by status
    async getTransactionsByStatus(userId, status) {
        try {
            return await Transaction.find({ status: status, user: userId })
                                     .populate('user')
                                     .populate('client')
                                     .populate('product')
                                     .populate('order');
        } catch (error) {
            throw new TransactionNotFoundError();
        }
    },

    // Retrieve all transactions for a specific client
    async getTransactionsByClientId(userId, clientId) {
        try {
            
            return await Transaction.find({ client: clientId, user: userId })
                                     .populate('user')
                                     .populate('product')
                                     .populate('order');
        } catch (error) {
            throw new TransactionNotFoundError();
        }
    }

};

module.exports = transactionService;
