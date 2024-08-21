const authService = require('../services/authService');
const logger = require('../utils/logger');

const authController = {
    register: async (req, res, next) => {
        try {
            const userData = req.body;
            const result = await authService.register(userData);
            
            if (result.user && result.token) {
                res.status(201).json({
                    user: { _id: result.user._id },
                    token: result.token,
                    message: 'Registration successful.'
                });
            } else {
                res.status(400).json({ message: 'Registration failed.' });
            }
        } catch (error) {
            logger.error(`Registration Controller Error: ${error.message}`);
            res.status(500).json({ message: 'Internal Server Error.' });
        }
    },

    login: async (req, res, next) => {
        try {
            const credentials = req.body;
            const result = await authService.login(credentials);
    
            if (result.user && result.token) {
                res.status(200).json({
                    user: result.user,
                    userId: { _id: result.user._id },
                    token: result.token,
                    message: 'Login successful.'
                });
            } else {
                console.log(result);
                res.status(400).json({ message: result  });
            }
        } catch (error) {
            logger.error(`Login Controller Error: ${error.message}`);
            res.status(500).json({ message: 'Internal Server Error.' });
        }
    },
    

    logout: async (req, res, next) => {
        try {
            const token = req.headers.authorization.split(' ')[1]; // Assuming the token is sent in the Authorization header
            const result = await authService.logout(token);
            res.status(200).json(result);
        } catch (error) {
            logger.error(`Logout Controller Error: ${error.message}`);
            res.status(500).json({ message: 'Internal Server Error.' });
        }
    },

    sendVerificationCode: async (req, res, next) => {
        try {
            const { email } = req.body;
            const result = await authService.sendVerificationCode(email);
            res.status(result.success ? 200 : 400).json(result);
        } catch (error) {
            logger.error(`Send Verification Code Controller Error: ${error.message}`);
            res.status(500).json({ message: 'Internal Server Error.' });
        }
    },

    verifyAndChangePassword: async (req, res, next) => {
        try {
            const { email, code, newPassword } = req.body;
            const result = await authService.verifyAndChangePassword(email, code, newPassword);
            res.status(result.success ? 200 : 400).json(result);
        } catch (error) {
            logger.error(`Verify and Change Password Controller Error: ${error.message}`);
            res.status(500).json({ message: 'Internal Server Error.' });
        }
    }
};

module.exports = authController;
