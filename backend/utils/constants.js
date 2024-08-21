// constants.js

// Define database status messages
const DB_MESSAGES = {
    CONNECTION_SUCCESS: 'Successfully connected to the database.',
    CONNECTION_ERROR: 'Error connecting to the database.'
  };
  
  // Define authentication-related constants
  const AUTH_CONSTANTS = {
    JWT_SECRET: process.env.JWT_SECRET || 'defaultSecretKey',
    TOKEN_EXPIRATION: '1h'
  };
  
  // Define general application messages
  const APP_MESSAGES = {
    SERVER_START: `Server is running on port ${process.env.PORT || 3000}`,
    SERVER_ERROR: 'Server encountered an error.'
  };
  
  // Define path to logs directory
  const LOG_DIRECTORY = './logs';
  
  // Other constants related to the app's business logic, configurations, etc. can be defined here.
  
  module.exports = {
    DB_MESSAGES,
    AUTH_CONSTANTS,
    APP_MESSAGES,
    LOG_DIRECTORY
  };
  