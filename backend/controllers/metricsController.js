const metricsService = require('../services/metricsService');

const metricsController = {

    // Add new metrics entry for a day
    addMetricsForDay: async (req, res, next) => {
        try {
            const metricsData = req.body;
            const newMetrics = await metricsService.addMetricsForDay(metricsData);
            return res.status(201).json({ success: true, message: "Metrics for the day added successfully", data: newMetrics });
        } catch (error) {
            next(error);
        }
    },

    // Fetch metrics for a specific date
    getMetricsForDate: async (req, res, next) => {
        try {
            const date = req.params.date;
            const metrics = await metricsService.getMetricsForDate(date);
            return res.status(200).json({ success: true, data: metrics });
        } catch (error) {
            next(error);
        }
    },

    // Fetch all metrics entries
    getAllMetrics: async (req, res, next) => {
        try {
            const allMetrics = await metricsService.getAllMetrics();
            return res.status(200).json({ success: true, data: allMetrics });
        } catch (error) {
            next(error);
        }
    },

    // Increment a specific metric for a given day
    incrementMetricForDate: async (req, res, next) => {
        try {
            const { date, metricName, value } = req.body;
            const updatedMetrics = await metricsService.incrementMetricForDate(date, metricName, value);
            return res.status(200).json({ success: true, message: "Metric incremented successfully", data: updatedMetrics });
        } catch (error) {
            next(error);
        }
    },

    // Delete metrics for a specific date
    deleteMetricsForDate: async (req, res, next) => {
        try {
            const date = req.params.date;
            await metricsService.deleteMetricsForDate(date);
            return res.status(200).json({ success: true, message: "Metrics for the date deleted successfully" });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = metricsController;
