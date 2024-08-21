const {
    ProductCreationError,
    ProductNotFoundError,
    ProductRetrievalByIdError,
    ProductUpdateError,
    ProductDeletionError,
    ProductsRetrievalByOwnerError
  } = require('../middleware/customErrors');
  const Product = require('../models/ProductModels');
  
  class ProductService {
    // Create a new product
    static async createProduct(userId, productData) {
      try {
        // Make sure userId and productData are not null or undefined
        if (!userId || !productData) {
          throw new Error("Missing userId or productData");
        }
        
        // Ensure the product is associated with the user
        productData.owner = userId;

        
    
        // Create a new product
        const product = new Product(productData);
        
        //Save the product
        const savedProduct = await product.save();
        
        return savedProduct;
        
      } catch (error) {
        console.error("Error while creating product: ", error);
        throw new ProductCreationError();
      }
    }
  
    // Get all products for a specific user
    static async getAllProducts(userId) {
      try {
        return await Product.find({ owner: userId });
      } catch (error) {
        throw new ProductNotFoundError();
      }
    }
  
    // Get product by ID
    static async getProductById(userId, productId) {
      try {
        const product = await Product.findById(productId);
        if (product.owner.toString() !== userId) {
          throw new ProductRetrievalByIdError(productId);
        }
        return product;
      } catch (error) {
        throw new ProductRetrievalByIdError(productId);
      }
    }
  
    // Update product by ID
    static async updateProductById(userId, productId, updateData) {
      try {
        const product = await Product.findById(productId);
        if (product.owner.toString() !== userId) {
          throw new ProductRetrievalByIdError(productId);
        }
        return await Product.findByIdAndUpdate(productId, updateData, { new: true });
      } catch (error) {
        throw new ProductUpdateError(productId);
      }
    }
  
    // Delete product by ID
    static async deleteProductById(userId, productId) {
      try {
        const product = await Product.findById(productId);
        if (product.owner.toString() !== userId) {
          throw new ProductRetrievalByIdError(productId);
        }
        return await Product.findByIdAndDelete(productId);
      } catch (error) {
        throw new ProductDeletionError(productId);
      }
    }
  
    // Get products for a specific user (owner)
    static async getProductsByOwnerId(userId) {
      try {
        return await Product.find({ owner: userId });
      } catch (error) {
        throw new ProductsRetrievalByOwnerError(userId);
      }
    }
  }
  
  module.exports = ProductService;
  