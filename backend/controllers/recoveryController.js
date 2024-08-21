const RecoveryService = require('../services/recoveryService');

const recoveryController = {

    // Trigger a backup for the current database state
    backupCurrentState: async (req, res, next) => {
        try {
            const userId = req.user._id; // Assuming you store the logged-in user's ID in req.user._id
            const backup = await RecoveryService.backupCurrentState(userId);
            res.status(201).json({ success: true, data: backup, message: 'Backup completed successfully.' });
        } catch (error) {
            next(error);
        }
    },

    // Restore the database from a backup
    recoverFromBackup: async (req, res, next) => {
        try {
            const userId = req.user._id; // Assuming you store the logged-in user's ID in req.user._id
            const backupId = req.params.backupId; // Assuming the backup ID is provided as a path parameter
            const result = await RecoveryService.recoverFromBackup(userId, backupId);
            res.status(200).json(result);
        } catch (error) {
            next(error);
        }
    },

    // NOTE: Clearing the database might be a dangerous operation in production. You might want to put some safeguards around this.
    clearDatabase: async (req, res, next) => {
        try {
            await RecoveryService.clearDatabase();
            res.status(200).json({ success: true, message: 'Database cleared successfully.' });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = recoveryController;
