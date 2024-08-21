const ProductService = require('../services/productService');

const productController = {
     

    // Create a new product
    createProduct: async (req, res, next) => {
        try {
            const productData = req.body.productInfo; // Retrieves the productInfo object
            const userId = req.body.userId; // Retrieves the userId
            const newProduct = await ProductService.createProduct(userId, productData);
            return res.status(201).json({ success: true, message: 'Product created successfully', data: newProduct });
        } catch (error) {
            console.log('Error details:', error);
            next(error);
        }
    },

    // Get all products
    getAllProducts: async (req, res, next) => {
        try {
            console.log("Fetching products from database..")
            const products = await ProductService.getAllProducts();
            return res.status(200).json({ success: true, data: products });
        } catch (error) {
            next(error);
        }
    },

    // Get product by ID
    getProductById: async (req, res, next) => {
        try {
            const productId = req.params.productId;
            const product = await ProductService.getProductById(productId);
            return res.status(200).json({ success: true, data: product });
        } catch (error) {
            next(error);
        }
    },

    // Update product by ID
    updateProductById: async (req, res, next) => {
        try {
            const productId = req.params.id;
            const userId = req.user.productId; // Assuming user ID is stored in req.user
            const updateData = req.body;
            const updatedProduct = await ProductService.updateProductById(userId, productId, updateData);
            return res.status(200).json({ success: true, message: 'Product updated successfully', data: updatedProduct });
        } catch (error) {
            next(error);
        }
    },

    // Delete product by ID
    deleteProductById: async (req, res, next) => {
        try {
            const productId = req.params.productId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            await ProductService.deleteProductById(userId, productId);
            return res.status(200).json({ success: true, message: 'Product deleted successfully' });
        } catch (error) {
            next(error);
        }
    },

    // Get products for a specific user (owner)
    getProductsByOwnerId: async (req, res, next) => {
        try {
            const ownerId = req.params.ownerId;
            // Assuming user ID is stored in req.user
            const products = await ProductService.getProductsByOwnerId(ownerId);
            return res.status(200).json({ success: true, data: products });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = productController;
