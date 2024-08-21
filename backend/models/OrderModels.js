const mongoose = require('mongoose');
const { imageValidator } = require('../utils/validators');

const orderSchema = new mongoose.Schema({
    user: {  // Refers to the business owner
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    client: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Client',
        required: true
    },
    products: [{
        product: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Product',
            required: true
        },
        quantity: {
            type: Number,
            required: true,
            min: 1
        }
    }],
    orderNumber: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    totalAmount: {
        type: Number,
        required: true,
        min: 0
    },
    status: {
        type: String,
        enum: ['Pending', 'Shipped', 'Delivered', 'Cancelled'],
        required: true,
        default: 'Pending'
    },
    orderDate: {
        type: Date,
        default: Date.now
    },
    deliveryDetails: {
        address: {
            type: String,
            required: true,
            trim: true
        },
        deliveryDate: {
            type: Date
        },
        deliveryStatus: {
            type: String,
            enum: ['Not Shipped', 'In Transit', 'Delivered'],
            default: 'Not Shipped'
        }
    }
});

module.exports = mongoose.model('Order', orderSchema);
