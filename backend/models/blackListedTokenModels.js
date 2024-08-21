const mongoose = require('mongoose');

const blacklistedTokenSchema = new mongoose.Schema({
    token: {
        type: String,
        required: true,
        unique: true,  // Ensure that the same token doesn't get blacklisted multiple times
    },
    dateBlacklisted: {
        type: Date,
        default: Date.now,  // Automatically set the current date when a token is blacklisted
    },
    // Optionally, you can add more fields like 'reason' or 'userId' if you'd like more context
});

// Create an index for faster queries. Especially useful if you have a lot of blacklisted tokens
blacklistedTokenSchema.index({ token: 1 });

const BlacklistedToken = mongoose.model('BlacklistedToken', blacklistedTokenSchema);

module.exports = BlacklistedToken;
