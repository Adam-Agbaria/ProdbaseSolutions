const mongoose = require('mongoose');

const profitSchema = new mongoose.Schema({
    user: {  // Refers to the business owner
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    order: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Order',
        required: true
    },
    products: [{
        product: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Product',
            required: true
        },
        quantitySold: {
            type: Number,
            required: true,
            min: 1
        },
        profitFromProduct: {
            type: Number,
            required: true,
            min: 0
        }
    }],
    client: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Client',
        required: true
    },
    profitAmount: {
        type: Number,
        required: true,
        min: 0
    },
    profitDate: {
        type: Date,
        default: Date.now
    },
    profitNumber: {
        type: String,
        required: true,
        unique: true,
        trim: true
    }
});

module.exports = mongoose.model('Profit', profitSchema);
