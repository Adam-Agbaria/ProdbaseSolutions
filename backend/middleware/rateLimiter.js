const rateLimit = require('express-rate-limit');

// Configure the rate limiter
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000,  // 15 minutes
    max: 100,  // limit each IP to 100 requests per windowMs
    message: "Too many requests from this IP, please try again later.",
    handler: (req, res, next) => {
        res.status(429).json({ error: 'Rate limit exceeded. Please try again after 1 minute.' });
      },
});
// Set up a rate limit configuration
const apiLimiter1 = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  max: 5, // limit each IP to 5 requests per window
  message: 'Rate limit exceeded. Please try again after 1 minute.', // response message for exceeding the limit
  handler: (req, res, next) => {
    res.status(429).json({ error: 'Rate limit exceeded. Please try again after 1 minute.' });
  },
});

module.exports = {
    limiter,
    apiLimiter1
};