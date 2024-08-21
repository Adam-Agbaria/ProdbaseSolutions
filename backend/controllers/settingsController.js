const SettingsService = require('../services/settingsService');

const settingsController = {

    // Create a new settings record for a user
    createSettings: async (req, res, next) => {
        try {
            const settingsData = req.body;
            const settings = await SettingsService.createSettings(settingsData);
            res.status(201).json({ success: true, data: settings });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve settings for a specific user
    getSettingsByUser: async (req, res, next) => {
        try {
            const userId = req.user._id; // Assuming the logged-in user's ID is available as req.user._id
            const settings = await SettingsService.getSettingsByUser(userId);
            if(!settings) {
                return res.status(404).json({ success: false, message: 'Settings not found.' });
            }
            res.status(200).json({ success: true, data: settings });
        } catch (error) {
            next(error);
        }
    },

    // Update settings for a specific user
    updateSettings: async (req, res, next) => {
        try {
            const userId = req.user._id;
            const updatedData = req.body;
            const settings = await SettingsService.updateSettings(userId, updatedData);
            if(!settings) {
                return res.status(404).json({ success: false, message: 'Settings not found.' });
            }
            res.status(200).json({ success: true, data: settings });
        } catch (error) {
            next(error);
        }
    },

    // Delete settings for a specific user
    deleteSettings: async (req, res, next) => {
        try {
            const userId = req.user._id;
            await SettingsService.deleteSettings(userId);
            res.status(204).send(); // 204 No Content
        } catch (error) {
            next(error);
        }
    }
};

module.exports = settingsController;
