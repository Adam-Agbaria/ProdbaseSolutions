const orderService = require('../services/orderService');

const orderController = {

    // Create a new order
    createOrder: async (req, res, next) => {
        try {
            const orderData = req.body;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const newOrder = await orderService.createOrder(userId, orderData);
            return res.status(201).json({ success: true, message: 'Order created successfully', data: newOrder });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve an order by its ID
    getOrderById: async (req, res, next) => {
        try {
            const orderId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const order = await orderService.getOrderById(userId, orderId);
            return res.status(200).json({ success: true, data: order });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve all orders for a specific user
    getOrdersByUserId: async (req, res, next) => {
        try {
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const orders = await orderService.getOrdersByUserId(userId);
            return res.status(200).json({ success: true, data: orders });
        } catch (error) {
            next(error);
        }
    },

    // Update an order by its ID
    updateOrderById: async (req, res, next) => {
        try {
            const orderId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const updateData = req.body;
            const updatedOrder = await orderService.updateOrderById(userId, orderId, updateData);
            return res.status(200).json({ success: true, message: 'Order updated successfully', data: updatedOrder });
        } catch (error) {
            next(error);
        }
    },

    // Delete an order by its ID
    deleteOrderById: async (req, res, next) => {
        try {
            const orderId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            await orderService.deleteOrderById(userId, orderId);
            return res.status(200).json({ success: true, message: 'Order deleted successfully' });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve all orders by their status
    getOrdersByStatus: async (req, res, next) => {
        try {
            const status = req.params.status;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const orders = await orderService.getOrdersByStatus(userId, status);
            return res.status(200).json({ success: true, data: orders });
        } catch (error) {
            next(error);
        }
    },

    // Retrieve all orders for a specific client
    getOrdersByClientId: async (req, res, next) => {
        try {
            const clientId = req.params.clientId;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const orders = await orderService.getOrdersByClientId(userId, clientId);
            return res.status(200).json({ success: true, data: orders });
        } catch (error) {
            next(error);
        }
    },

    // Change the delivery status of an order
    updateDeliveryStatus: async (req, res, next) => {
        try {
            const orderId = req.params.id;
            const userId = req.user.id; // Assuming user ID is stored in req.user
            const deliveryStatus = req.body.deliveryStatus;
            const updatedOrder = await orderService.updateDeliveryStatus(userId, orderId, deliveryStatus);
            return res.status(200).json({ success: true, message: 'Delivery status updated successfully', data: updatedOrder });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = orderController;
