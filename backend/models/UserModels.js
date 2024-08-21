const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const { emailValidator, passwordValidator, urlValidator, ipValidator, checkValidationResult } = require('../utils/validators');
const isISO31661Alpha2 = require('validator').isISO31661Alpha2;
const isCurrency = require('validator').isCurrency;


const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        minlength: 4,
        validate: {
            validator: (v) => {
                return /^[a-zA-Z0-9_]+$/.test(v); // Alphanumeric and underscore
            },
            message: 'Username can only contain alphanumeric characters and underscores and has a minimum of 4 characters'
        }
    },
    email: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        trim: true,
        validate: {
            validator: (v) => {
                // Use the email validator function and just return its result
                return emailValidator(v);
            },
            message: 'Please enter a valid email address'
        }
    },
    password: {
        type: String,
        required: true,
        minlength: 8,
        validate: {
            validator: (v) => {
                // Use the password validator function and just return its result
                return passwordValidator(v);
            },
            message: 'Password must meet the specified criteria'
        }
    },
    companyName: {
        type: String,
        trim: true,
        default: ''
    },
    subscriptionStatus: {
        type: Boolean,
        default: false
    },
    subscriptionEndDate: {
        type: Date,
        default: null
    },
    settings: {
        theme: {
            type: String,
            default: 'light',
            enum: ['light', 'dark']
        },
        notificationPreferences: {
            email: {
                type: Boolean,
                default: true
            },
            push: {
                type: Boolean,
                default: true
            }
        },
        timeZone: {
            type: String,
            default: 'UTC',
            validate: [isISO31661Alpha2, 'Please provide a valid ISO 3166-1 alpha-2 country code']
        },
        currency: {
            type: String,
            default: 'USD',
            validate: [isCurrency, 'Please provide a valid currency code']
        },
        subscription: {
            status: {
                type: Boolean,
                default: false
            },
            renewal: {
                autoRenew: {
                    type: Boolean,
                    default: true
                },
                paymentMethod: {
                    type: String,
                    enum: ['creditCard', 'paypal', 'bankTransfer'],
                    default: 'creditCard'
                },
                lastPaymentDate: {
                    type: Date,
                    default: null
                },
                nextPaymentDate: {
                    type: Date,
                    default: null
                }
            }
        }
    },
    dateJoined: {
        type: Date,
        default: Date.now
    },
    lastLogin: {
        type: Date,
        default: null
    }
});

// Hash password before saving
userSchema.pre('save', async function(next) {
    const user = this;

    if (user.isModified('password')) {
        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(user.password, salt);
    }

    next();
});

// Add a method to validate the password against the hashed version
userSchema.methods.isValidPassword = async function(password) {
    const user = this;
    return await bcrypt.compare(password, user.password);
};

module.exports = mongoose.model('User', userSchema);
