const mongoose = require('mongoose');
const logger = require('../utils/logger');  // Make sure to adjust the path to your logger.js
const { DB_CONNECTION_STRING } = require('./envConfig');
DB_CONNECTION_STRING_FINAL = DB_CONNECTION_STRING ;
//'mongodb://localhost:27017'
const dbOptions = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000
};

const connectToDatabase = async () => {
  try {
    await mongoose.connect(DB_CONNECTION_STRING_FINAL, dbOptions);
    logger.info('Successfully connected to the database.');
  } catch (error) {
    logger.error('Error connecting to the database:', error);
    process.exit(1);
  }
};

module.exports = {
  connectToDatabase
};
