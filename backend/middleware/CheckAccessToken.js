const jwt = require('jsonwebtoken');

const TokenService = require('../services/tokenService');
const RefreshToken = require('../models/refreshTokenModels');
const { JWT_SECRET } = require('../config/envConfig');


module.exports = async (req, res, next) => {
    try {

        const token = req.headers.authorization.split(' ')[1];
        const decoded = jwt.verify(token, JWT_SECRET);
        console.log(token);
        req.user = decoded;
        next();
    } catch (err) {
        // if (err.name === "TokenExpiredError") {
            try {
                // const decodedToken = jwt.decode(token);
                // const userId = decodedToken.id;

                // const refreshTokenDoc = await RefreshToken.findOne({ user: userId });
                // if (!refreshTokenDoc) {
                //     return res.status(401).json({ error: "Unauthorized, didn't find the refresh token." });
                // }

                // const newTokens = await TokenService.refreshToken(refreshTokenDoc.token);
                // res.locals.newAccessToken = newTokens.accessToken;
                
                // req.user = jwt.decode(newTokens.accessToken); // Assuming the new token also contains user info
                next();
            } catch (refreshErr) {
                console.log(`Refresh token error: ${refreshErr}`);
                res.status(401).json({ error: "Unauthorized" });
            }
        // } else {
        //     console.error(`JWT error: ${err}`);
        //     res.status(401).json({ error: "Unauthorized" });
        // }
    }
};
