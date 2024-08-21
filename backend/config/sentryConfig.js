const Sentry = require('@sentry/node');

// Load environment variables
const { SENTRY_DSN, NODE_ENV } = require('./envConfig');

// Initialize Sentry
Sentry.init({
    dsn: SENTRY_DSN,
    environment: NODE_ENV,
    // Additional configuration options can go here, if needed
});

const captureException = (error, req, res, next) => {
    // Capture the error and send it to Sentry
    Sentry.captureException(error);

    // Optionally, you can log the error to console as well
    console.error(error);

    // If you want to use this as a middleware, call the next function
    // otherwise, remove this line and don't use it as middleware
    next(error);
};

module.exports = {
    Sentry,
    captureException
};
