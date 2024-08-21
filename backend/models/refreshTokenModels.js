const mongoose = require('mongoose');


const refreshTokenSchema = new mongoose.Schema({
    token: {
        type: String,
        required: true,
        unique: true
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    expiresAt: {
        type: Date,
        required: true
    }
});

// Optional: You might want to set up an index on the expiresAt field for better performance
// when querying expired tokens
refreshTokenSchema.index({ expiresAt: 1 });

module.exports = mongoose.model('RefreshToken', refreshTokenSchema);
