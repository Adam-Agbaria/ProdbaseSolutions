// utils/encryptionUtility.js

const crypto = require('crypto');

const ENCRYPTION_KEY = process.env.ENCRYPTION_KEY || 'defaultEncryptionKey'; // Should be 32 bytes
const IV_LENGTH = 16; // For AES, this is always 16

/**
 * Encrypts text using AES-256-CBC algorithm
 * @param {string} text - The text to be encrypted.
 * @returns {string} - Encrypted text.
 */
const encrypt = (text) => {
    const iv = crypto.randomBytes(IV_LENGTH);
    const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(ENCRYPTION_KEY), iv);
    const encrypted = Buffer.concat([cipher.update(text, 'utf8'), cipher.final()]);

    return iv.toString('hex') + ':' + encrypted.toString('hex');
}

/**
 * Decrypts text using AES-256-CBC algorithm
 * @param {string} text - The encrypted text to be decrypted.
 * @returns {string} - Decrypted text.
 */
const decrypt = (text) => {
    const textParts = text.split(':');
    const iv = Buffer.from(textParts.shift(), 'hex');
    const encryptedText = Buffer.from(textParts.join(':'), 'hex');
    const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(ENCRYPTION_KEY), iv);

    return decipher.update(encryptedText, 'hex', 'utf8') + decipher.final('utf8');
}

module.exports = {
    encrypt,
    decrypt
};
