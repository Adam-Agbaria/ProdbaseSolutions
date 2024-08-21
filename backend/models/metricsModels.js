const mongoose = require('mongoose');

const metricsSchema = new mongoose.Schema({
    date: {
        type: Date,
        default: Date.now
    },
    activeUsers: { // Number of users that logged in or interacted with the app on a given day
        type: Number,
        default: 0
    },
    newRegistrations: { // Number of new users registered
        type: Number,
        default: 0
    },
    subscribedUsers: {  // Users who subscribed on a particular day
        type: Number,
        default: 0
    },
    unsubscribedUsers: {  // Users who unsubscribed on a particular day
        type: Number,
        default: 0
    },
    totalTransactions: { // Total transactions processed on a given day
        type: Number,
        default: 0
    },
    totalOrders: { // Total orders made on a given day
        type: Number,
        default: 0
    },
    totalProductsAdded: { // New products added by all users
        type: Number,
        default: 0
    },
    totalRevenue: { // Total revenue earned (could be from transactions or other revenue streams)
        type: Number,
        default: 0.0
    },
    averageOrderValue: { // The average monetary value of orders placed on a given day
        type: Number,
        default: 0.0
    },
    errorsLogged: { // Total number of errors logged in the system on a given day
        type: Number,
        default: 0
    },
    successfulBackups: { // Number of successful backups on a particular day
        type: Number,
        default: 0
    },
    failedBackups: { // Number of failed backup attempts
        type: Number,
        default: 0
    }
});

// Possible methods to update metrics incrementally
metricsSchema.methods.incrementMetric = function(metricName, value = 1) {
    this[metricName] += value;
    return this.save();
};

module.exports = mongoose.model('Metrics', metricsSchema);
