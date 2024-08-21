const mongoose = require('mongoose');
const backupService = require('./backupService');
const { DatabaseClearError, BackupReadingError, BackupDataError, RestoreFromBackupError, RecoveryError } = require('../middleware/customErrors');

const recoveryService = {

    // Backup the current state of the database.
    async backupCurrentState(userId) {
        // For simplicity, we'll consider a full backup. 
        // You can expand this logic based on your requirements.
        try{
            const backupData = {
                user: userId,
                backupType: 'full',
                // ... other fields based on the data you want to back up.
            };
        }catch (error) {
            throw new BackupCreationError();
        }
        const backup = await backupService.createBackup(backupData);
        return backup;
    },

    // Clear the entire database (all collections).
    async clearDatabase() {
        try{
            const collections = mongoose.connection.collections;

            for (const key in collections) {
                const collection = collections[key];
                await collection.deleteMany(); // Clears the collection.
            }
        }catch (error) {
            throw new DatabaseClearError();
        }
    },

    // Restore from the backup. This assumes you have a method to extract data from a backup.
    async restoreFromBackup(backup) {
        // Determine the path of the backup from the backup object (assuming 'location' field contains the path)
        const backupPath = path.join(__dirname, '..', backup.location);

        // Check if backup file exists
        let backupData;
        try {
            const rawData = await fs.readFile(backupPath, 'utf8');
            backupData = JSON.parse(rawData);
        } catch (err) {
            throw new BackupReadingError();
        }

        if (!backupData) {
            throw new BackupDataError();
        }
        try{
            for (const collectionName in backupData) {
                const collectionData = backupData[collectionName];
                const collection = mongoose.connection.collection(collectionName);
                await collection.insertMany(collectionData);
            }
        }catch (error) {
            throw new RestoreFromBackupError();
        }
    },

    // The main method to recover from a backup.
    async recoverFromBackup(userId, backupId) {
        try {
            // 1. Backup current state.
            await this.backupCurrentState(userId);

            // 2. Clear the database.
            await this.clearDatabase();

            // 3. Restore from the given backup.
            const backup = await backupService.getBackupById(backupId);
            await this.restoreFromBackup(backup);

            return { success: true, message: 'Recovery successful.' };

        } catch (error) {
            throw new RecoveryError('Recovery failed: ' + error.message);
        }
    }
};

module.exports = recoveryService;
