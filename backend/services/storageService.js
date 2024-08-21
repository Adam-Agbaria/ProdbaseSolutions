const fs = require('fs');
const path = require('path');
const multer = require('multer');
const { FileNotFoundError, FileDeletionError } = require('../middleware/customErrors');

const storageDirectory = path.join(__dirname, '..', 'uploads'); // Assuming you have an 'uploads' directory at the root

// Setting up multer to store files
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, storageDirectory);
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix);
    }
});

const upload = multer({ storage: storage });

const storageService = {

    // Save a file
    saveFile: upload.single('file'), // 'file' is the field name

    // Retrieve a file
    getFile: (fileName) => {
        const filePath = path.join(storageDirectory, fileName);
        if (fs.existsSync(filePath)) {
            return fs.createReadStream(filePath);
        } else {
            throw new FileNotFoundError();
        }
    },

    // Delete a file
    deleteFile: (fileName) => {
        const filePath = path.join(storageDirectory, fileName);
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        } else {
            throw new FileDeletionError();
        }
    }
};

module.exports = storageService;
