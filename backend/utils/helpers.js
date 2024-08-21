const crypto = require('crypto');

/**
 * Format a JavaScript Date object into a string
 * @param {Date} date - The Date object
 * @return {string} - Formatted date string
 */
const formatDate = (date) => {
    return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });
};

/**
 * Generate a random string of the given length
 * @param {number} length - Length of the random string
 * @return {string} - Random string
 */
const generateRandomToken = (length = 32) => {
    return crypto.randomBytes(length).toString('hex');
};

/**
 * Helper function to paginate array results
 * @param {Array} data - Array of data to paginate
 * @param {number} currentPage - Current page number
 * @param {number} perPage - Number of items per page
 * @return {Object} - Paginated results and metadata
 */
const paginate = (data, currentPage = 1, perPage = 10) => {
    const offset = (currentPage - 1) * perPage;
    const paginatedItems = data.slice(offset, offset + perPage);

    return {
        currentPage,
        perPage,
        total: data.length,
        totalPages: Math.ceil(data.length / perPage),
        data: paginatedItems,
    };
};

/**
 * Format API responses to maintain consistent structure
 * @param {boolean} success - Whether the request was successful
 * @param {string} message - Message associated with the response
 * @param {Object} data - Data payload
 * @return {Object} - Formatted response
 */
const formatResponse = (success, message, data = null) => {
    return {
        success,
        message,
        data,
    };
};

function stringToPaymentMethod(str) {
    switch (str) {
      case 'CreditCard':
        return 'Credit Card';
      case 'Cash':
        return 'Cash';
      case 'BankTransfer':
        return 'Bank Transfer';
      case 'Online':
        return 'Online';
      default:
        throw new Error("Invalid payment method");
    }
  }
  
  function stringToTransactionStatus(str) {
    switch (str) {
    
      case 'Completed':
        return 'Completed';
      case 'Pending':
        return 'Pending';
      case 'Refunded':
        return 'Refunded';
      case 'Failed':
        return 'Failed';
      default:
        throw new Error("Invalid transaction status");
    }
  }
  

module.exports = {
    formatDate,
    generateRandomToken,
    paginate,
    formatResponse,
    stringToPaymentMethod,
    stringToTransactionStatus
};
