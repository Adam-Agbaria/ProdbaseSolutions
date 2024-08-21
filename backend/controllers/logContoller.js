const logService = require('../services/logService');

const logController = {

    createLog: async (req, res, next) => {
        try {
            const logData = req.body;
            const newLog = await logService.createLog(logData);
            return res.status(201).json({ success: true, message: "Log entry created successfully", data: newLog });
        } catch (error) {
            next(error);
        }
    },

    getAllLogs: async (req, res, next) => {
        try {
            const logs = await logService.getAllLogs();
            return res.status(200).json({ success: true, data: logs });
        } catch (error) {
            next(error);
        }
    },

    getLogsByType: async (req, res, next) => {
        try {
            const logType = req.params.logType;
            const logs = await logService.getLogsByType(logType);
            return res.status(200).json({ success: true, data: logs });
        } catch (error) {
            next(error);
        }
    },

    getLogsByUser: async (req, res, next) => {
        try {
            const userId = req.params.userId;
            const logs = await logService.getLogsByUser(userId);
            return res.status(200).json({ success: true, data: logs });
        } catch (error) {
            next(error);
        }
    },

    getLogsByModule: async (req, res, next) => {
        try {
            const moduleType = req.params.moduleType;
            const logs = await logService.getLogsByModule(moduleType);
            return res.status(200).json({ success: true, data: logs });
        } catch (error) {
            next(error);
        }
    },

    deleteLog: async (req, res, next) => {
        try {
            const logId = req.params.logId;
            await logService.deleteLog(logId);
            return res.status(200).json({ success: true, message: "Log entry deleted successfully" });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = logController;
