const User = require('../models/UserModels');
const { validationResult } = require('express-validator');
const logger = require('../utils/logger'); // Assuming you have a logger in utils
const { UserCreationError, UserNotFoundError, UserDeletionError, UserUpdateError } = require('../middleware/customErrors');

const userService = {

    createUser: async (data) => {
        try {
            const user = new User(data);
            await user.save();
            logger.info(`User with id ${user._id} created`);
            return user;
        } catch (error) {
            logger.error(`Error creating user: ${error.message}`);
            throw new UserCreationError();
        }
    },

    getUserById: async (id) => {
        try {
            return await User.findById(id).select('-password'); // excluding password for security reasons
        } catch (error) {
            logger.error(`Error fetching user by id ${id}: ${error.message}`);
            throw new UserNotFoundError(id);
        }
    },

    updateUser: async (id, data) => {
        try {
            const user = await User.findByIdAndUpdate(id, data, { new: true });
            logger.info(`User with id ${id} updated`);
            return user;
        } catch (error) {
            logger.error(`Error updating user with id ${id}: ${error.message}`);
            throw new UserUpdateError(id);
        }
    },

    deleteUser: async (id) => {
        try {
            await User.findByIdAndDelete(id);
            logger.info(`User with id ${id} deleted`);
        } catch (error) {
            logger.error(`Error deleting user with id ${id}: ${error.message}`);
            throw new UserDeletionError(id);
        }
    },

    validateUserInput: (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            logger.error(`User input validation error: ${errors.array()}`);
            return res.status(400).json({ errors: errors.array() });
        }
        next();
    }

};

module.exports = userService;
