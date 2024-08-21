const logService = require('../services/logService');
const logger = require('../utils/logger');

const loggingMiddleware = async (req, res, next) => {
    try {
        const logData = {
            method: req.method,  // HTTP method, e.g., GET, POST, PUT, DELETE
            path: req.path,  // The path of the request, e.g., /users or /posts/1
            ip: req.ip,  // IP address of the requester
            user: req.user ? req.user._id : null,  // Store user ID if the user is logged in
            type: 'HTTP_REQUEST',  // This can be customized based on your needs
            module: 'HTTP_MODULE',  // This can be further fine-tuned to denote specific parts of your application
            timestamp: Date.now()  // Current time
        };

        // Create a log entry
        await logService.createLog(logData);
        next();
    } catch (error) {
        logger.error("Logging error: ", error.message);
        next();  // Even if there's an error in logging, we proceed to the next middleware/route
    }
};

module.exports = loggingMiddleware;
