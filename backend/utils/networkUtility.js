// utils/networkUtility.js

const dns = require('dns');
const axios = require('axios');

/**
 * Pings a hostname to check if it's reachable.
 * @param {string} hostname - The hostname or IP to ping.
 * @returns {Promise<boolean>} - A promise that resolves to true if the host is reachable, false otherwise.
 */
const ping = (hostname) => {
    return new Promise((resolve, reject) => {
        dns.resolve(hostname, (err) => {
            if (err) {
                resolve(false);
            } else {
                resolve(true);
            }
        });
    });
}

/**
 * Fetches the external IP of the current server.
 * @returns {Promise<string>} - A promise that resolves to the external IP.
 */
const getExternalIP = async () => {
    try {
        const response = await axios.get('https://api.ipify.org?format=json');
        return response.data.ip;
    } catch (error) {
        throw new Error('Failed to fetch external IP');
    }
}

/**
 * Checks if a given string is a valid IP address.
 * @param {string} ip - The IP address.
 * @returns {boolean} - True if valid, false otherwise.
 */
const isValidIP = (ip) => {
    return net.isIP(ip) !== 0;
}

module.exports = {
    ping,
    getExternalIP,
    isValidIP
};
