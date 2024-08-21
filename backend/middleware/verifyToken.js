const jwt = require('jsonwebtoken');
const BlacklistedToken = require('../models/blackListedTokenModels');
const secret = process.env.JWT_SECRET || 'ProdBaseSolutionsSuperSecretKey@450380';
const { TokenVerificationError, TokenNotFoundError } = require('./customErrors');

const verifyToken = async (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'No token provided' });
    }

    // Check if the token is blacklisted
    const blacklistedToken = await BlacklistedToken.findOne({ token });
  
    if (blacklistedToken) {
        return res.status(401).json({ error: 'Token has been blacklisted' });
    }
    
    jwt.verify(token, secret, (err, user) => {
        if (err) {
            throw new TokenVerificationError('Token is not valid');
        }
        
        req.user = user;  // If verification is successful, attach the decoded payload to the request object
        next();
    });
};

module.exports = verifyToken;
