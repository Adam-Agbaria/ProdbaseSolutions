const Log = require('../models/logModels');

const logService = {
    // Create a new log entry
    createLog: async (logData) => {
        try {
            const log = new Log(logData);
            return await log.save();
        } catch (error) {
            throw new LogCreationError();
        }
    },

    // Retrieve all logs
    getAllLogs: async () => {
        try {
            return await Log.find().sort('-timestamp');  // sorted by most recent first
        } catch (error) {
            throw new FetchLogsError();
        }
    },

    // Retrieve logs by type
    getLogsByType: async (logType) => {
        try {
            return await Log.find({ type: logType }).sort('-timestamp');
        } catch (error) {
            throw new FetchLogsByTypeError(logType);
        }
    },

    // Retrieve logs by user
    getLogsByUser: async (userId) => {
        try {
            return await Log.find({ user: userId }).sort('-timestamp');
        } catch (error) {
            throw new FetchLogsByUserError(userId);
        }
    },

    // Retrieve logs by module
    getLogsByModule: async (moduleType) => {
        try {
            return await Log.find({ module: moduleType }).sort('-timestamp');
        } catch (error) {
            throw new FetchLogsByModuleError(moduleType);
        }
    },

    // Delete a specific log entry
    deleteLog: async (logId) => {
        try {
            return await Log.findByIdAndDelete(logId);
        } catch (error) {
            throw new LogDeletionError();
        }
    }
};

module.exports = logService;
