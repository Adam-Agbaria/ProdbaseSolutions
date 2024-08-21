const mongoose = require('mongoose');
const { emailValidator } = require('../utils/validators');
const isCurrency = require('validator').isCurrency;


const settingsSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    theme: {
        type: String,
        enum: ['light', 'dark'],
        default: 'light'
    },
    appName: {
        type: String,
        default: 'ProdBase Solutions'
    },
    maintenanceMode: {
        type: Boolean,
        default: false
    },
    subscriptionCost: {  // Monthly subscription cost for users
        type: Number,
        default: 29.99
    },
    currency: { 
        type: String,
        default: 'USD',
        validate: isCurrency
    },
    taxRate: {  // Percentage tax rate for transactions
        type: Number,
        default: 0,
        min: 0,
        max: 100
    },
    supportEmail: {  // Email address for user support
        type: String,
        validate: emailValidator,
        required: true
    },
    notificationSettings: {
        dailyReport: {  // Whether to send a daily report email to admin
            type: Boolean,
            default: true
        },
        errorNotifications: {  // Whether to notify admin on application errors
            type: Boolean,
            default: true
        }
    },
    backupSettings: {
        autoBackup: {  // Whether to backup the database automatically
            type: Boolean,
            default: true
        },
        backupFrequency: {  // Could be 'daily', 'weekly', 'monthly'
            type: String,
            enum: ['daily', 'weekly', 'monthly'],
            default: 'daily'
        }
    }
});

module.exports = mongoose.model('Settings', settingsSchema);
