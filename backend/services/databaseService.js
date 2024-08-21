const mongoose = require('mongoose');
const User = require('../models/UserModels');
const Client = require('../models/ClientModels');
const Product = require('../models/ProductModels');
const Transaction = require('../models/TransactionModels');
const Order = require('../models/OrderModels');
const Settings = require('../models/settingsModels');
const logger = require('../utils/logger');  // Assuming you have a logger in the utils

class DatabaseService {
    constructor() {
        this.uri = process.env.DATABASE_URI || 'mongodb://localhost:27017/business-management-app';
    }

    async connect() {
        try {
            await mongoose.connect(this.uri, {
                useNewUrlParser: true,
                useUnifiedTopology: true,
                useCreateIndex: true
            });
            logger.info("Connected to the database successfully.");
        } catch (error) {
            logger.error("Error connecting to the database:", error);
        }
    }

    // // User operations
    // async createUser(data) {
    //     return await User.create(data);
    // }

    // async updateUser(owner, data) {
    //     return await User.findByIdAndUpdate(owner, data, { new: true });
    // }

    // async deleteUser(owner) {
    //     return await User.findByIdAndDelete(owner);
    // }

    // async findUserById(owner) {
    //     return await User.findById(owner);
    // }

    // async findAllUsers() {
    //     return await User.find();
    // }

    // // Client operations
    // async createClient(data) {
    //     return await Client.create(data);
    // }

    // async updateClient(clientId, data) {
    //     return await Client.findByIdAndUpdate(clientId, data, { new: true });
    // }

    // async deleteClient(clientId) {
    //     return await Client.findByIdAndDelete(clientId);
    // }

    // async findClientById(clientId) {
    //     return await Client.findById(clientId);
    // }

    // async findAllClients() {
    //     return await Client.find();
    // }

    // // Product operations
    // async createProduct(data) {
    //     return await Product.create(data);
    // }

    // async updateProduct(productId, data) {
    //     return await Product.findByIdAndUpdate(productId, data, { new: true });
    // }

    // async deleteProduct(productId) {
    //     return await Product.findByIdAndDelete(productId);
    // }

    // async findProductById(productId) {
    //     return await Product.findById(productId);
    // }

    // async findAllProducts() {
    //     return await Product.find();
    // }

    // async createTransaction(data) {
    //     return await Transaction.create(data);
    // }

    // async updateTransaction(transactionId, data) {
    //     return await Transaction.findByIdAndUpdate(transactionId, data, { new: true });
    // }

    // async deleteTransaction(transactionId) {
    //     return await Transaction.findByIdAndDelete(transactionId);
    // }

    // async findTransactionById(transactionId) {
    //     return await Transaction.findById(transactionId);
    // }

    // async findAllTransactions() {
    //     return await Transaction.find();
    // }

    // // Order operations
    // async createOrder(data) {
    //     return await Order.create(data);
    // }

    // async updateOrder(orderId, data) {
    //     return await Order.findByIdAndUpdate(orderId, data, { new: true });
    // }

    // async deleteOrder(orderId) {
    //     return await Order.findByIdAndDelete(orderId);
    // }

    // async findOrderById(orderId) {
    //     return await Order.findById(orderId);
    // }

    // async findAllOrders() {
    //     return await Order.find();
    // }

    // // Settings operations
    // async getSettings() {
    //     return await Settings.findOne();
    // }

    // async updateSettings(data) {
    //     return await Settings.findOneAndUpdate({}, data, { upsert: true, new: true });
    // }

    // UserSettings operations
    // async getUserSettings(owner) {
    //     return await UserSettings.findOne({ owner });
    // }

    // async updateUserSettings(owner, data) {
    //     return await UserSettings.findOneAndUpdate({ owner }, data, { upsert: true, new: true });
    // }
}

module.exports = new DatabaseService();
