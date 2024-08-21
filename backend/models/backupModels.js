const mongoose = require('mongoose');

const backupSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    backupDate: {
        type: Date,
        default: Date.now
    },
    backupType: { // E.g., "full", "incremental", "differential", etc.
        type: String,
        required: true,
        enum: ['full', 'incremental', 'differential', 'user_data', 'products', 'clients', 'transactions', 'orders', 'profits']
    },
    description: {
        type: String,
        trim: true
    },
    location: { // Could be a file path or cloud storage URL
        type: String,
        required: true
    },
    status: { // E.g., "completed", "in_progress", "failed", etc.
        type: String,
        default: 'completed',
        enum: ['completed', 'in_progress', 'failed']
    },
    dataSize: { // In bytes, for keeping track of the size of the backup
        type: Number,
        required: true
    }
});

module.exports = mongoose.model('Backup', backupSchema);
