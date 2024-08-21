const express = require('express');
const StorageService = require('../services/storageService');

const storageController = {

    // Upload a file
    uploadFile: async (req, res, next) => {
        StorageService.saveFile(req, res, (err) => {
            if (err) {
                return next(err);
            }
            res.status(201).json({
                success: true,
                message: 'File uploaded successfully',
                fileName: req.file.filename // Filename that's saved on the server
            });
        });
    },

    // Download a file
    downloadFile: async (req, res, next) => {
        try {
            const fileName = req.params.fileName; // Assuming the route is /files/:fileName
            const fileStream = StorageService.getFile(fileName);

            // Set the appropriate headers
            res.setHeader('Content-Disposition', 'attachment; filename=' + fileName);
            fileStream.pipe(res);
        } catch (error) {
            next(error);
        }
    },

    // Delete a file
    removeFile: async (req, res, next) => {
        try {
            const fileName = req.params.fileName;
            StorageService.deleteFile(fileName);
            res.status(200).json({
                success: true,
                message: 'File deleted successfully'
            });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = storageController;
