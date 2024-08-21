const mongoose = require('mongoose');
const { emailValidator } = require('../utils/validators');

const clientSchema = new mongoose.Schema({
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // Reference to the User model indicating which user the client belongs to.
        required: true
    },
    clientNumber: {
        type: String,
        required: true,
        unique: true, // Ensuring the client number is unique
        trim: true
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: false,
        lowercase: true,
        trim: true,
        // validate: [ 
        //     {
        //         validator: value => emailValidator(value),
        //         message: 'Invalid email address'
        //     }
        // ]
    },
    phoneNumber: {
        type: String,
        trim: true
    },
    address: {
        street: {
            type: String,
            trim: true
        },
        city: {
            type: String,
            trim: true
        },
        postalCode: {
            type: String,
            trim: true
        },
        country: {
            type: String,
            trim: true
        }
    },
    notes: {
        type: String, // Any additional information the user might want to save about the client
        trim: true
    },
    dateAdded: {
        type: Date,
        default: Date.now
    },
    lastUpdated: {
        type: Date,
        default: Date.now
    }
});

// Middleware to update the lastUpdated field whenever the client is modified
clientSchema.pre('save', function(next) {
    if (this.isModified()) {
        this.lastUpdated = Date.now();
    }
    next();
});

module.exports = mongoose.model('Client', clientSchema);
