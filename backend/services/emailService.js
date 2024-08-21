const nodemailer = require('nodemailer');
const validator = require('validator'); // Email format validator
const verifyEmail = require('email-verify'); // For email existence check
const User = require('../models/UserModels'); // Assuming user model has 'confirmationCode' field
const logger = require('../utils/logger');

class EmailService {
    async sendConfirmationEmail(user) {
        try {
            // Validate the email format
            if (!validator.isEmail(user.email)) {
                logger.error(`Invalid email format: ${user.email}`);
                return { success: false, message: 'Invalid email format' };
            }

            // Check if the email actually exists
            const result = await new Promise((resolve) => {
                verifyEmail.check(user.email, (err, info) => {
                    if (err || !info.success) {
                        resolve(false);
                    } else {
                        resolve(true);
                    }
                });
            });

            if (!result) {
                logger.error(`Email does not exist: ${user.email}`);
                return { success: false, message: 'Email does not exist' };
            }

            const transporter = nodemailer.createTransport({
                service: 'gmail',
                auth: {
                    user: process.env.EMAIL_USER,
                    pass: process.env.EMAIL_PASSWORD,
                },
            });

            // Generate a random 6-digit confirmation code
            const confirmationCode = Math.floor(100000 + Math.random() * 900000);

            const mailOptions = {
                from: process.env.EMAIL_USER,
                to: user.email,
                subject: 'Email Confirmation',
                text: `Your 6-digit confirmation code is: ${confirmationCode}`,
            };

            await transporter.sendMail(mailOptions);
            logger.info(`Confirmation email sent to ${user.email}`);

            // Update the user with the confirmation code
            user.confirmationCode = confirmationCode;
            await user.save();

            return { success: true, confirmationCode };
        } catch (error) {
            logger.error(`Error sending email: ${error.message}`);
            return { success: false, message: error.message };
        }
    }

    async forgotPasswordMail(email) {
        try {
            // Validate the email format
            if (!validator.isEmail(email)) {
                logger.error(`Invalid email format: ${email}`);
                return { success: false, message: 'Invalid email format' };
            }

            // Check if the email actually exists
            const user = await User.findOne({ email });

            if (!user) {
                logger.error(`User not found: ${email}`);
                return { success: false, message: 'User not found' };
            }

            const transporter = nodemailer.createTransport({
                service: 'gmail',
                auth: {
                    user: process.env.EMAIL_USER,
                    pass: process.env.EMAIL_PASSWORD,
                },
            });

            // Generate a random 6-digit password reset code
            const resetCode = Math.floor(100000 + Math.random() * 900000);

            const mailOptions = {
                from: process.env.EMAIL_USER,
                to: email,
                subject: 'Password Reset',
                text: `Your 6-digit password reset code is: ${resetCode}`,
            };

            await transporter.sendMail(mailOptions);
            logger.info(`Password reset email sent to ${email}`);

            // Update the user with the reset code
            user.resetPasswordCode = resetCode;
            user.resetPasswordCodeExpiresAt = Date.now() + 10 * 60 * 1000; // 10 minutes
            await user.save();

            return { success: true, resetCode };
        } catch (error) {
            logger.error(`Error sending password reset email: ${error.message}`);
            return { success: false, message: error.message };
        }
    }

    async verifyConfirmationCode(email, enteredCode) {
        try {
            // Retrieve the user by email
            const user = await User.findOne({ email });

            if (!user) {
                logger.error(`User not found: ${email}`);
                return { success: false, message: 'User not found' };
            }

            // Compare the entered code with the stored code
            if (user.confirmationCode !== enteredCode) {
                logger.error(`Invalid confirmation code for email: ${email}`);
                return { success: false, message: 'Invalid confirmation code' };
            }

            // If codes match, update user's email verification status
            user.emailVerified = true;
            user.confirmationCode = null; // Optionally clear the code
            await user.save();

            logger.info(`Email verified for ${email}`);
            return { success: true, message: 'Email verified successfully' };
        } catch (error) {
            logger.error(`Error verifying email: ${error.message}`);
            return { success: false, message: error.message };
        }
    }
}

module.exports = new EmailService();
