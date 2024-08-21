const { SettingsCreationError, SettingsNotFoundError, SettingsUpdateError, SettingsDeletionError } = require('../middleware/customErrors');
const Settings = require('../models/settingsModels');

const settingsService = {
    // 1. Create a new settings record for a user
    createSettings: async (settingsData) => {
        try {
            const settings = new Settings(settingsData);
            return await settings.save();
        } catch (error) {
            throw new SettingsCreationError();
        }
    },

    // 2. Retrieve settings for a specific user
    getSettingsByUser: async (userId) => {
        try {
            return await Settings.findOne({ user: userId });
        } catch (error) {
            throw new SettingsNotFoundError(userId);
        }
    },

    // 3. Update settings for a specific user
    updateSettings: async (userId, updatedData) => {
        try {
            return await Settings.findOneAndUpdate({ user: userId }, updatedData, { new: true });
        } catch (error) {
            throw new SettingsUpdateError(userId);
        }
    },

    // 4. Delete settings for a specific user
    deleteSettings: async (userId) => {
        try {
            return await Settings.findOneAndDelete({ user: userId });
        } catch (error) {
            throw new SettingsDeletionError(userId);
        }
    }
};

module.exports = settingsService;
