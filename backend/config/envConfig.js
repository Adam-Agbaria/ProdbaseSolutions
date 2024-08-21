const dotenv = require('dotenv');
const path = require('path');
const fs = require('fs');

// Debug: Print current working directory
// console.log("Current Working Directory:", process.cwd());

// Debug: Verify the file actually exists
const envPath = path.join(process.cwd(), '.env');
// if (fs.existsSync(envPath)) {
//   console.log('.env file exists');
// } else {
//   console.log('.env file does NOT exist');
// }

// Load environment variables from .env file
dotenv.config({ path: envPath });



// Here, you can validate that certain environment variables are set
// and throw errors if they are not, ensuring your app doesn't start without them.
if (!process.env.DB_CONNECTION_STRING) {

    throw new Error("DB_CONNECTION_STRING environment variable not set.");
}

// Add validations for any other environment variables you consider necessary

module.exports = {
    NODE_ENV: process.env.NODE_ENV || 'development',
    PORT: process.env.PORT || 3000,

    // Database
    DB_CONNECTION_STRING: process.env.DB_CONNECTION_STRING,

    // JWT Configuration
    JWT_SECRET: process.env.JWT_SECRET,

    // Redis Configuration
    REDIS_HOST: process.env.REDIS_HOST,
    REDIS_PORT: parseInt(process.env.REDIS_PORT, 10) || 6379,  // Default Redis port
    REDIS_PASSWORD: process.env.REDIS_PASSWORD,
    BASE_URL: process.env.BASE_URL
    // ... add more as needed
};
