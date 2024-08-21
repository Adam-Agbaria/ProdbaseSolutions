const multer = require('multer');

// Configure storage
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, './uploads/'); // Specify the destination directory
    },
    filename: function(req, file, cb) {
        // You can rename the uploaded file here
        cb(null, Date.now() + '-' + file.originalname);
    }
});

// File filter to check for specific types (optional)
const fileFilter = (req, file, cb) => {
    // Allow only jpg, png, and jpeg for this example
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png' || file.mimetype === 'image/jpg') {
        cb(null, true);
    } else {
        cb(new Error('Invalid file type'), false);
    }
};

// Initialize multer with storage option and file filter
const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5 // Limit file size to 5MB
    },
    fileFilter: fileFilter
});

// This middleware function can be used in routes that expect a single file with the field name 'file'
module.exports = upload.single('file');
