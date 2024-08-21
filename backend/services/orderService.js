const {
    OrderCreationError,
    OrderNotFoundError,
    OrderUpdateError,
    OrderDeletionError,
    OrdersRetrievalByStatusError,
    DeliveryStatusUpdateError
  } = require('../middleware/customErrors');
  const Order = require('../models/OrderModels');
  
  const orderService = {
  
    // Create a new order
    async createOrder(userId, orderData) {
      try {
        orderData.user = userId; // Ensure the order is associated with the user
        const order = new Order(orderData);
        return await order.save();
      } catch (error) {
        throw new OrderCreationError(orderData);
      }
    },
  
    // Retrieve an order by its ID
    async getOrderById(userId, orderId) {
      try {
        const order = await Order.findById(orderId)
          .populate('user')
          .populate('client')
          .populate('products.product');
        if (order.user.toString() !== userId) {
          throw OrderNotFoundError(orderId);
        }
        return order;
      } catch (error) {
        throw OrderNotFoundError(orderId);
      }
    },
  
    // Retrieve all orders for a specific user
    async getOrdersByUserId(userId) {
      try {
        return await Order.find({ user: userId })
          .populate('client')
          .populate('products.product');
      } catch (error) {
        throw new OrdersRetrievalByUserError(userId);
      }
    },
  
    // Update an order by its ID
    async updateOrderById(userId, orderId, updateData) {
      try {
        const order = await Order.findById(orderId);
        if (order.user.toString() !== userId) {
          throw OrderNotFoundError(orderId);
        }
        return await Order.findByIdAndUpdate(orderId, updateData, { new: true })
          .populate('user')
          .populate('client')
          .populate('products.product');
      } catch (error) {
        throw new OrderUpdateError(orderId);
      }
    },
  
    // Delete an order by its ID
    async deleteOrderById(userId, orderId) {
      try {
        const order = await Order.findById(orderId);
        if (order.user.toString() !== userId) {
          throw OrderNotFoundError(orderId);
        }
        return await Order.findByIdAndDelete(orderId);
      } catch (error) {
        throw new OrderDeletionError(orderId);
      }
    },
  
    // Retrieve all orders by their status
    async getOrdersByStatus(userId, status) {
      try {
        return await Order.find({ user: userId, status: status })
          .populate('user')
          .populate('client')
          .populate('products.product');
      } catch (error) {
        throw new OrdersRetrievalByStatusError(status);
      }
    },
  
    // Retrieve all orders for a specific client
    async getOrdersByClientId(userId, clientId) {
      try {
        return await Order.find({ user: userId, client: clientId })
          .populate('user')
          .populate('products.product');
      } catch (error) {
        throw new OrdersRetrievalByClientError(clientId);
      }
    },
  
    // Change the delivery status of an order
    async updateDeliveryStatus(userId, orderId, deliveryStatus) {
      try {
        const order = await Order.findById(orderId);
        if (!order || order.user.toString() !== userId) {
          throw new Error('Order not found');
        }
        order.deliveryDetails.deliveryStatus = deliveryStatus;
        return await order.save();
      } catch (error) {
        throw new DeliveryStatusUpdateError(orderId);
      }
    }
  
  };
  
  module.exports = orderService;
  