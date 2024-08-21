const express = require('express');
const TransactionService = require('../services/transactionService');

const transactionController = {

    // Create a new transaction
    createTransaction: async (req, res, next) => {
        try {
            console.log(req.body);
            const transactionData = req.body.TransactionInfo;
            const userId = req.body.userId; // Assuming user ID is stored in req.user
            const transaction = await TransactionService.createTransaction(userId, transactionData);
            res.status(201).json({ success: true, data: transaction });
        } catch (error) {
            console.log(req.error);
            next(error);
        }
    },

    // Retrieve a transaction by its ID
    getTransaction: async (req, res, next) => {
        try {
            const transactionId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const transaction = await TransactionService.getTransactionById(userId, transactionId);
            res.status(200).json({ success: true, data: transaction });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve all transactions for a specific user
    getTransactionsForUser: async (req, res, next) => {
        try {
            const userId = req.params.userId; // Assuming user ID is stored in req.user
            const transactions = await TransactionService.getTransactionsByUserId(userId);
            res.status(200).json({ success: true, data: transactions });
        } catch (error) {
            next(error);
        }
    },

    // Update a transaction
    updateTransaction: async (req, res, next) => {
        try {
            const transactionId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const updatedData = req.body;
            const updatedTransaction = await TransactionService.updateTransactionById(userId, transactionId, updatedData);
            res.status(200).json({ success: true, data: updatedTransaction });
        } catch (error) {
            next(error);
        }
    },

    // Delete a transaction
    deleteTransaction: async (req, res, next) => {
        try {
            const transactionId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            await TransactionService.deleteTransactionById(userId, transactionId);
            res.status(200).json({ success: true, message: 'Transaction deleted successfully' });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve transactions by status
    getTransactionsByStatus: async (req, res, next) => {
        try {
            const status = req.params.status;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const transactions = await TransactionService.getTransactionsByStatus(userId, status);
            res.status(200).json({ success: true, data: transactions });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve transactions for a specific client
    getTransactionsForClient: async (req, res, next) => {
        try {
            const clientId = req.params.clientId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const transactions = await TransactionService.getTransactionsByClientId(userId, clientId);
            res.status(200).json({ success: true, data: transactions });
        } catch (error) {
            next(error);
        }
    }

};

module.exports = transactionController;
