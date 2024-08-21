const { body, check, validationResult } = require('express-validator');
const multer = require('multer');

// Middleware for validating an email address
const emailValidator = body('email')
    .isEmail()
    .withMessage('Invalid email address')
    .normalizeEmail();

// Middleware for validating a password
const passwordValidator = body('password')
    .isLength({ min: 8 })
    .withMessage('Password must be at least 8 characters long')
    .matches(/[a-zA-Z]/)
    .withMessage('Password must contain at least one letter')
    .matches(/\d/)
    .withMessage('Password must contain at least one number')
    .matches(/[A-Z]/)
    .withMessage('Password must contain at least one uppercase letter') // Check for an uppercase letter
    // .matches(/[!@#$%^&*(),.?":{}|<>]/)
    // .withMessage('Password must contain at least one special character');

// Middleware for validating a username
const usernameValidator = body('username')
    .isLength({ min: 4, max: 16 })
    .withMessage('Username must be between 4 and 16 characters long')
    .matches(/^[a-zA-Z0-9-_]+$/)
    .withMessage('Username can contain only letters, numbers, hyphens, and underscores');

// Middleware for validating a URL
const urlValidator = body('url')
    .isURL()
    .withMessage('Invalid URL');

// Middleware for validating an IP address
const ipValidator = body('ip')
    .isIP()
    .withMessage('Invalid IP address');

// Middleware to check the validation result and send appropriate response
const checkValidationResult = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }
    next();
};

// Setting up Multer for image uploads
const imageStorage = multer.memoryStorage(); // Store the file data in memory
const imageUpload = multer({
    storage: imageStorage,
    limits: {
        fileSize: 5 * 1024 * 1024 // 5 MB
    },
    fileFilter: (req, file, cb) => {
        const allowedMimes = [
            'image/jpeg',
            'image/pjpeg',
            'image/png',
            'image/gif'
        ];

        if (allowedMimes.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error('Invalid file type. Only JPEG, PNG and GIF image files are allowed.'), false);
        }
    }
});

// Middleware for validating photo uploads
const photoValidator = [
    // Using Multer to handle file uploads
    imageUpload.single('photo'), // 'photo' is the name of the field in your form

    // Express-validator check for file presence
    check('photo')
        .custom((value, { req }) => {
            if (!req.file) {
                throw new Error('A photo is required.');
            }
            return true;
        })
];



module.exports = {
    emailValidator,
    passwordValidator,
    usernameValidator,
    urlValidator,
    ipValidator,
    checkValidationResult,
    photoValidator,

};
