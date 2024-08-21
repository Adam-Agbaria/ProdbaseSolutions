const jwt = require('jsonwebtoken');
const { TokenVerificationError, RefreshTokenExpiredError, TokenNotFoundError, InvalidRefreshTokenError, UserNotFoundError } = require('../middleware/customErrors');
const secret = process.env.JWT_SECRET || 'P';
const RefreshToken = require('../models/refreshTokenModels');


const tokenService = {
    generateToken: async (user) => {
        const payload = {
            id: user._id,
            username: user.username,
            email: user.email,
        };
        console.log("Debug: Payload created:", payload);

        try {
            const refreshToken = jwt.sign(payload, secret, { expiresIn: Math.floor(Date.now() / 1000) + (60 * 60 * 24 * 365 * 10) }); // 10 years
            console.log("Debug: Refresh token generated:", refreshToken);

            const accessToken = jwt.sign({ id: user._id }, secret, { expiresIn: '7d' });
            console.log("Debug: Access token generated:", accessToken);

            // Store the refresh token in the database
            const newRefreshToken = new RefreshToken({
                token: refreshToken,
                user: user._id,
                expiresAt: Date.now() + 60 * 60 * 24 * 365 * 10 * 1000
            });
            
            console.log("Debug: New refresh token object created:", newRefreshToken);

            await newRefreshToken.save();

            console.log("Debug: Refresh token saved in database.");

    
            return {
                accessToken: accessToken,
                refreshToken: refreshToken
            };
        } catch (error) {
            console.error(`An error occurred while generating tokens: ${error.message}`);
            return null; // Return null to indicate that token generation failed
        }
    },

    verifyToken: (token) => {
        try {
            return jwt.verify(token, secret);
        } catch (error) {
            throw new TokenVerificationError();
        }
    },

    refreshToken: async (refreshToken) => {
        if (!refreshToken) {
            throw new TokenNotFoundError();
        }
        let decodedToken;
        try {
            decodedToken = jwt.verify(refreshToken, secret);
        } catch (error) {
            throw new TokenVerificationError();
        }
        const tokenInDb = await RefreshToken.findOne({ token: refreshToken });
        if (!tokenInDb) {
            throw new InvalidRefreshTokenError();
        }
        const now = Date.now();
        if (tokenInDb.expiresAt < now) {
            await tokenInDb.remove();
            throw new RefreshTokenExpiredError();
        }
        const user = await User.findById(decodedToken.id);
        if (!user) {
            throw new UserNotFoundError();
        }
        const newAccessToken = this.generateToken(user);
        const newRefreshToken = jwt.sign({ id: user._id }, secret, { expiresIn: '7d' });
        await tokenInDb.remove();
        const newTokenEntry = new RefreshToken({ 
            token: newRefreshToken, 
            user: user._id, 
            expiresAt: now + 7 * 24 * 60 * 60 * 1000
        });
        await newTokenEntry.save();

        return {
            accessToken: newAccessToken,
            refreshToken: newRefreshToken
        };
    }
};
module.exports = tokenService;
