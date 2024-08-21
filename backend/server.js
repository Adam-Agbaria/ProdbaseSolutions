const express = require('express');
const app = express();
const logger = require('./utils/logger');
const CheckAccessToken = require('./middleware/CheckAccessToken');
const { limiter, apiLimiter1 } = require('./middleware/rateLimiter');
const loggingMiddleware = require('./middleware/loggingMiddleware');
const errorHandler = require('./middleware/errorHandler');
const customErrors = require('./middleware/customErrors');
// Routes
const analyticsRoutes = require('./routes/analyticsRoutes');
const authRoutes = require('./routes/authRoutes');
const backupRoutes = require('./routes/backupRoutes');
const clientRoutes = require('./routes/clientRoutes');
const logRoutes = require('./routes/logRoutes');
const metricsRoutes = require('./routes/metricsRoutes');
const orderRoutes = require('./routes/orderRoutes');
const productRoutes = require('./routes/productRoutes');
const profitRoutes = require('./routes/profitRoutes');
const transactionRoutes = require('./routes/transactionRoutes');
const recoveryRoutes = require('./routes/recoveryRoutes');
const settingsRoutes = require('./routes/settingsRoutes');
const storageRoutes = require('./routes/storageRoutes');
const tokenRoutes = require('./routes/tokenRoutes');
const userRoutes = require('./routes/userRoutes');

const helmet = require('helmet');
const session = require('express-session');

// const { REDIS_HOST, REDIS_PORT } = require('./envConfig');


process.on('unhandledRejection', (reason, promise) => {
    logger.error('Unhandled Rejection at:', promise, 'reason:', reason);
    // You might want to do a graceful shutdown or restart here
});

process.on('uncaughtException', (err) => {
    logger.error('Uncaught Exception thrown:', err);
    // Again, a graceful shutdown or restart would be beneficial here
});



// process.on('exit', () => {
//     redisClient.quit();
// });


// 1. Load environment configurations
const { PORT } = require('./config/envConfig');

logger.info('Attempting to connect to the database...'); // <-- Add this line
// 2. Connect to the database
const { connectToDatabase } = require('./config/dbconfig');
connectToDatabase()
    .then(() => {
        logger.info('Database connected. Initializing middleware...');
        
        // Your existing middleware setup...
    })
    .catch(err => {
        logger.error('Database connection failed:', err);
        process.exit(1);  // <-- This would be an explicit exit point with code 1 if the DB connection fails.
    });


// Global middleware
app.use(loggingMiddleware);

// Setting http headers for security
app.use(helmet());

// Middleware for JSON payload
app.use(express.json());

// Middleware for URL-encoded form data
app.use(express.urlencoded({ extended: true }));








app.use(session({
    secret: process.env.SESSION_SECRET || 'default-session-secret', 
    resave: false,
    saveUninitialized: false,
    cookie: {
        maxAge: 3600000, // 1 hour
        secure: process.env.NODE_ENV === 'production', // Ensure this is true if you're in a production environment with HTTPS
        httpOnly: true,
        sameSite: 'strict'
    }
}));

// Apply the general limiter to all requests
app.use(limiter);

// Routes which need rate limiting
const routesWithRateLimit = [
    '/api/auth/login', 
    '/api/auth/signup', 
    '/api/backup', 
    '/api/recovery', 
    '/api/token'
];
routesWithRateLimit.forEach(route => {
    app.use(route, apiLimiter1);
});

// Routes which require authentication
const routesRequiringAuth = [
    '/api/analytics',
    '/api/user',
    '/api/clients',
    '/api/orders',
    '/api/products',
    '/api/profits',
    '/api/settings',
    '/api/storage',
    '/api/logout'
];
routesRequiringAuth.forEach(route => {
    app.use(route, CheckAccessToken);
});

// Routes definition
app.use('/api/analytics', analyticsRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/backup', backupRoutes);
app.use('/api/clients', clientRoutes);
app.use('/api/logs', logRoutes);
app.use('/api/metrics', metricsRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/products', productRoutes);
app.use('/api/transactions', transactionRoutes);
app.use('/api/profits', profitRoutes);
app.use('/api/recovery', recoveryRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/storage', storageRoutes);
app.use('/api/token', tokenRoutes);
app.use('/api/user', userRoutes);


app.get('/', (req, res) => {
    res.json({ message: 'API is running!' });
});


// Error handlers should be the last middlewares
app.use((err, req, res, next) => {
    console.log(`${req.method} ${req.url}`, req.body);
    logger.info(`${req.method} ${req.url}`, req.body);
    // logger.error(`${err.status || 500} - ${err.message} - ${req.originalUrl} - ${req.method} - ${req.ip}`);
    errorHandler(err, req, res, next);
});

app.listen(5000, () => {
    logger.info('Server is running on port 5000');
});


