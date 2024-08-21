const backupService = require('../services/backupService');
const logger = require('../utils/logger');

const backupController = {
    
    // 1. Create a new backup record
    createBackup: async (req, res) => {
        try {
            const backupData = req.body;
            const replacePrevious = req.query.replacePrevious || false;
            const newBackup = await backupService.createBackup(backupData, replacePrevious);

            return res.status(201).json({
                success: true,
                message: "Backup created successfully",
                data: newBackup
            });
        } catch (error) {
            logger.error(`Backup creation failed: ${error.message}`);
            return res.status(500).json({
                success: false,
                message: "Backup creation failed"
            });
        }
    },

    // 2. Retrieve all backups for a specific user
    getAllBackupsByUser: async (req, res) => {
        try {
            const userId = req.params.userId;
            const backups = await backupService.getAllBackupsByUser(userId);

            return res.status(200).json({
                success: true,
                data: backups
            });
        } catch (error) {
            logger.error(`Fetching backups failed: ${error.message}`);
            return res.status(500).json({
                success: false,
                message: "Failed to fetch backups"
            });
        }
    },

    // 3. Retrieve a specific backup using its ID
    getBackupById: async (req, res) => {
        try {
            const backupId = req.params.backupId;
            const backup = await backupService.getBackupById(backupId);

            if (!backup) {
                return res.status(404).json({
                    success: false,
                    message: "Backup not found"
                });
            }

            return res.status(200).json({
                success: true,
                data: backup
            });
        } catch (error) {
            logger.error(`Fetching backup failed: ${error.message}`);
            return res.status(500).json({
                success: false,
                message: "Failed to fetch backup"
            });
        }
    },

    // 4. Update the status of a backup
    updateBackupStatus: async (req, res) => {
        try {
            const backupId = req.params.backupId;
            const status = req.body.status;
            const updatedBackup = await backupService.updateBackupStatus(backupId, status);

            return res.status(200).json({
                success: true,
                message: "Backup status updated successfully",
                data: updatedBackup
            });
        } catch (error) {
            logger.error(`Updating backup status failed: ${error.message}`);
            return res.status(500).json({
                success: false,
                message: "Failed to update backup status"
            });
        }
    },

    // 5. Delete a backup record
    deleteBackup: async (req, res) => {
        try {
            const backupId = req.params.backupId;
            await backupService.deleteBackup(backupId);

            return res.status(200).json({
                success: true,
                message: "Backup deleted successfully"
            });
        } catch (error) {
            logger.error(`Deleting backup failed: ${error.message}`);
            return res.status(500).json({
                success: false,
                message: "Failed to delete backup"
            });
        }
    }
};

module.exports = backupController;
