const mongoose = require('mongoose');
const { urlValidator } = require('../utils/validators'); // Importing our URL validator

const productSchema = new mongoose.Schema({
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // Reference to the User model
        required: true
    },
    productNumber: {
        type: String,
        required: true,
        unique: true, // Ensuring the product number is unique
        trim: true
    },
    name: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        trim: true
    },
    price: {
        type: Number,
        required: true,
        min: 0
    },
    stock: {
        type: Number,
        default: 0,
        min: 0
    },
    category: {
        type: String,
        trim: true
    },
    imageUrl: {
        type: String,
        trim: true,
        // validate: {
        //     validator: (v) => urlValidator(v), // Using our imported URL validator
        //     message: 'Invalid image URL'
        // }
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

// Middleware to update the lastUpdated field whenever the product is modified
productSchema.pre('save', function(next) {
    if (this.isModified()) {
        this.lastUpdated = Date.now();
    }
    next();
});

module.exports = mongoose.model('Product', productSchema);
