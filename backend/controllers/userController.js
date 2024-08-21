const UserService = require('../services/userService');

const userController = {

    // Create a user
    createUser: async (req, res, next) => {
        try {
            const user = await UserService.createUser(req.body);
            res.status(201).json(user);
        } catch (error) {
            next(error);
        }
    },

    // Retrieve a user by its ID
    getUser: async (req, res, next) => {
        try {
            console.log("Trying to get the user...")
            const user = await UserService.getUserById(req.params.id);
            if (!user) return res.status(404).json({ message: "User not found." });
            res.status(200).json(user);
        } catch (error) {
            next(error);
        }
    },

    // Update a user by its ID
    updateUser: async (req, res, next) => {
        try {
            const updatedUser = await UserService.updateUser(req.params.id, req.body);
            if (!updatedUser) return res.status(404).json({ message: "User not found." });
            res.status(200).json(updatedUser);
        } catch (error) {
            next(error);
        }
    },

    // Delete a user by its ID
    deleteUser: async (req, res, next) => {
        try {
            await UserService.deleteUser(req.params.id);
            res.status(200).json({ success: true, message: 'User deleted successfully' });
        } catch (error) {
            next(error);
        }
    },

    // Validate user input
    validateInput: (req, res, next) => {
        UserService.validateUserInput(req, res, next);
    }
};

module.exports = userController;
