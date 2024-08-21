const express = require('express');
const TokenService = require('../services/tokenService');

const tokenController = {

    // Generate a new token
    generateTokenForUser: async (req, res, next) => {
        try {
            const token = TokenService.generateToken(req.user);
            res.status(201).json({
                success: true,
                accessToken: token
            });
        } catch (error) {
            next(error);
        }
    },

    // Validate an access token
    validateToken: (req, res, next) => {
        try {
            const token = req.headers.authorization.split(' ')[1];  // Assuming "Bearer <token>" format
            const decoded = TokenService.verifyToken(token);
            res.status(200).json({
                success: true,
                userId: decoded.id,
                username: decoded.username,
                email: decoded.email
            });
        } catch (error) {
            next(error);
        }
    },

    // Refresh an access token using a refresh token
    refreshUserToken: async (req, res, next) => {
        try {
            const refreshToken = req.body.refreshToken;
            const tokens = await TokenService.refreshToken(refreshToken);
            res.status(200).json({
                success: true,
                accessToken: tokens.accessToken,
                refreshToken: tokens.refreshToken
            });
        } catch (error) {
            next(error);
        }
    }

};

module.exports = tokenController;
