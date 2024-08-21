const mongoose = require('mongoose');
const { imageValidator } = require('../utils/validators');

const transactionSchema = new mongoose.Schema({    ////ADD SUPERMARKET TRANSACTION FIELD
    user: {  // Refers to the business owner
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    clientId: {
        type: String,
        required: true,
        trim: true
    },
    product: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product'
    }],
    order: {  // Reference to the Order model
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Order',
        required: false  // Assuming it's not always linked to an order
    },
    transactionNumber: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    amount: {
        type: Number,
        required: true,
        min: 0
    },
    paymentMethod: {
        type: String,
        enum: ['Credit Card', 'Cash', 'Bank Transfer', 'Online'],
        required: true
    },
    status: {
        type: String,
        enum: ['Completed', 'Pending', 'Refunded', 'Failed'],
        required: true
    },
    transactionDate: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model('Transaction', transactionSchema);
