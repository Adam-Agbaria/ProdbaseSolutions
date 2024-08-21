const mongoose = require('mongoose');

const logSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: false, // Not all logs might be associated with a user
    },
    type: { // E.g., "error", "activity", "transaction", etc.
        type: String,
        required: true,
        enum: ['error', 'activity', 'transaction', 'system', 'backup', 'authentication']
    },
    timestamp: {
        type: Date,
        default: Date.now
    },
    message: { // A description or message related to the log event
        type: String,
        required: true
    },
    details: { // Additional details or metadata for the log
        type: Object,
        required: false,
        default: {}
    },
    ip: { // IP address from where the request was made (useful for user activity or authentication logs)
        type: String,
        required: false
    },
    userAgent: { // Information about the browser or client that made the request
        type: String,
        required: false
    },
    module: { // Which module or part of the application does this log belong to. E.g., 'product', 'client', 'order', etc.
        type: String,
        enum: ['user', 'product', 'client', 'transaction', 'order', 'profit', 'backup', 'other'],
        default: 'other'
    }
});

module.exports = mongoose.model('Log', logSchema);
