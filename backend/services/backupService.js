// const { BackupCreationError, FetchBackupByIdError, FetchBackupsError, BackupUpdateError, BackupDeletionError } = require('../middleware/customErrors');
const Backup = require('../models/backupModels');

const backupService = {
    
    // 1. Create a new backup record, with an option to replace the previous backup
    createBackup: async (backupData, replacePrevious = false) => {
        try {
            if (replacePrevious) {
                const previousBackup = await Backup.findOne({ user: backupData.user }).sort('-backupDate');  // fetch the most recent backup for the user
                if (previousBackup) {
                    await Backup.findByIdAndDelete(previousBackup._id);  // delete the most recent backup
                }
            }
            const backup = new Backup(backupData);
            return await backup.save();
        } catch (error) {
            throw new BackupCreationError();
        }
    },

    // 2. Retrieve all backups for a specific user
    getAllBackupsByUser: async (userId) => {
        try {
            return await Backup.find({ user: userId }).sort('-backupDate');  // sorted by most recent first
        } catch (error) {
            throw new FetchBackupsError();
        }
    },

    // 3. Retrieve a specific backup using its ID
    getBackupById: async (backupId) => {
        try {
            return await Backup.findById(backupId);
        } catch (error) {
            throw new FetchBackupByIdError();
        }
    },

    // 4. Update the status of a backup
    updateBackupStatus: async (backupId, status) => {
        try {
            return await Backup.findByIdAndUpdate(backupId, { status }, { new: true });
        } catch (error) {
            throw new BackupUpdateError();
        }
    },

    // 5. Delete a backup record
    deleteBackup: async (backupId) => {
        try {
            return await Backup.findByIdAndDelete(backupId);
        } catch (error) {
            throw new BackupDeletionError();
        }
    }
};

module.exports = backupService;
