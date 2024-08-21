// const { FetchMetricsByDateError, IncrementMetricsError, DeleteMetricsByDateError, FetchAllMetricsError, MetricsCreationError } = require('../middleware/customErrors');
const Metrics = require('../models/metricsModels');

const metricsService = {
    // 1. Add new metrics entry for a day
    addMetricsForDay: async (metricsData) => {
        try {
            const metrics = new Metrics(metricsData);
            return await metrics.save();
        } catch (error) {
            throw new MetricsCreationError();
        }
    },

    // 2. Fetch metrics for a specific date
    getMetricsForDate: async (date) => {
        try {
            return await Metrics.findOne({ date });
        } catch (error) {
            throw new FetchMetricsByDateError(date);
        }
    },

    // 3. Fetch all metrics entries
    getAllMetrics: async () => {
        try {
            return await Metrics.find().sort('-date'); // sorted by most recent first
        } catch (error) {
            throw new FetchAllMetricsError();
        }
    },

    // 4. Increment a specific metric for a given day
    incrementMetricForDate: async (date, metricName, value = 1) => {
        try {
            const metrics = await Metrics.findOne({ date });
            if (!metrics) {
                throw new FetchMetricsByDateError(date);
            }

            metrics.incrementMetric(metricName, value);
            return await metrics.save();
        } catch (error) {
            throw new IncrementMetricsError();
        }
    },

    // 5. Delete metrics for a specific date
    deleteMetricsForDate: async (date) => {
        try {
            return await Metrics.findOneAndDelete({ date });
        } catch (error) {
            throw new DeleteMetricsByDateError(date);
        }
    }
};

module.exports = metricsService;
