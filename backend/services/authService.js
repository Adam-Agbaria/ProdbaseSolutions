const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const validator = require('../utils/validators');
const User = require('../models/UserModels');
const tokenService = require('../services/tokenService');
const logger = require('../utils/logger');
const argon2 = require('argon2');
const RefreshToken = require('../models/refreshTokenModels');  // Assuming you have this model
const BlacklistedToken = require('../models/blackListedTokenModels');  // This is a hypothetical model for storing blacklisted tokens
// const { IncorrectPasswordError, LoginError, RegistrationError, InvalidEmailError } = require('../middleware/customErrors');

const JWT_SECRET = process.env.JWT_SECRET || 'ProdBasesupersecretultrakey';

const authService = {
    register: async (data, providedCode) => {
        try {
            // Validate email format
            if (!validator.isEmail(data.email)) {
                logger.error('Invalid email format');
                return { success: false, message: 'Invalid email format' };
            }

            // Validate password
            if (!validator.isValidPassword(data.password)) {
                logger.error('Invalid password');
                return { success: false, message: 'Invalid password' };
            }

            // Hash the password
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(data.password, salt);

            // // Generate and send confirmation code using EmailService
            // const emailService = new EmailService();
            // const confirmationCode = await emailService.sendConfirmationEmail({ email: data.email });

            // // Check the provided code against the generated code
            // if (confirmationCode !== parseInt(providedCode, 10)) {
            //     logger.error('Incorrect confirmation code');
            //     return { success: false, message: 'Incorrect confirmation code' };
            // }

            // Create user
            const user = new User({
                username: data.username,
                email: data.email,
                password: hashedPassword
            });

            const savedUser = await user.save();
            savedUser.password = undefined;

            const token = tokenService.generateToken(savedUser);
            const refreshToken = jwt.sign({ id: savedUser._id }, JWT_SECRET, { expiresIn: '7d' });
            const newRefreshToken = new RefreshToken({
                token: refreshToken,
                user: savedUser._id,
                expiresAt: Date.now() + 7 * 24 * 60 * 60 * 1000
            });
            await newRefreshToken.save();

            return {
                success: true,
                user: savedUser,
                token,
                refreshToken
            };
        } catch (error) {
            logger.error(`Registration failed: ${error.message}`);
            return { success: false, message: 'Registration failed' };
        }
    },

    login: async (credentials) => {
        const response = {
            success: false,
            message: '',
            user: null,
            token: null,
            refreshToken: null
        };
        
        if (!credentials || !credentials.email) {
            logger.error('Login failed: Credentials or email not provided');
            response.message = 'Credentials or email not provided';
            return response;
        }

        try {
            const user = await User.findOne({ email: credentials.email });
    
            if (!user) {
                response.message = 'User not found';
                logger.error('Login failed: User not found');  // Add this line
                return response;
            }
    
            const isMatch = await bcrypt.compare(credentials.password, user.password);

            if (!isMatch) {
            response.message = 'Incorrect password';
            logger.error('Login failed: Incorrect password');
            return response;
            }
    
            // Generate token using tokenService
            const token = await tokenService.generateToken(user);

            if (token === null) {
                logger.error('Login failed: Token generation failed');
                response.message = 'Login failed: Token generation failed';
                return response;
            }

            // const refreshToken = jwt.sign({ id: user._id }, JWT_SECRET, { expiresIn: '7d' });
            // const newRefreshToken = new RefreshToken({
            //     token: refreshToken,
            //     user: user._id,
            //     expiresAt: Date.now() + 7 * 24 * 60 * 60 * 1000
            // });
            // await newRefreshToken.save();
    
            response.success = true;
            response.user = user;
            response.token = token.accessToken;
            response.refreshToken = token.refreshToken;
            return response;
    
        } catch (error) {
            logger.error(`Login failed: ${error.message}`);
            response.message = 'Login failed';
            return response;
        }
    },
    

    logout: async (req, res) => {
        const { token } = req.body; // Assuming you're sending the token as a request body

        try {
            // Delete the refresh token associated with the provided token
            await refreshToken.findOneAndDelete({ token }); // Assuming the model has the 'token' field

            req.session.destroy((err) => {
                if (err) {
                    return res.status(500).json({ success: false, message: "Error logging out" });
                }
                res.clearCookie('connect.sid');
                res.status(200).json({ success: true, message: "Logged out!" });
            });
            
        } catch (error) {
            console.error(`Logout Error: ${error.message}`);
            res.status(500).json({ success: false, message: "Error logging out" });
        }
    },

    async sendVerificationCode(email) {
        try {
            // Send the 6-digit code to the user's email
            const sendCodeResult = await EmailService.forgotPasswordMail(email);
            if (!sendCodeResult.success) {
                return sendCodeResult; // Return the error message from sending code
            }

            return { success: true, message: 'Verification code sent successfully' };
        } catch (error) {
            logger.error(`Error sending verification code: ${error.message}`);
            return { success: false, message: error.message };
        }
    },

    async verifyAndChangePassword(email, enteredCode, newPassword) {
        try {
            // Verify the entered code with the stored code
            const verifyResult = await EmailService.verifyConfirmationCode(email, enteredCode);
            if (!verifyResult.success) {
                return verifyResult; // Return the error message from verifying code
            }

            // Retrieve the user
            const user = await User.findOne({ email });
            if (!user) {
                logger.error(`User not found: ${email}`);
                return { success: false, message: 'User not found' };
            }

            // Hash the new password
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(newPassword, salt);

            // Update the user's password
            user.password = hashedPassword;
            user.resetPasswordCode = null; // Optionally clear the code
            user.resetPasswordCodeExpiresAt = null; // Optionally clear the expiration time
            await user.save();

            logger.info(`Password changed for ${email}`);
            return { success: true, message: 'Password changed successfully' };
        } catch (error) {
            logger.error(`Error changing password: ${error.message}`);
            return { success: false, message: error.message };
        }
    }


    // ... Other authService functions ...
};

module.exports = authService;
