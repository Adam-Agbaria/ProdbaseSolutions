const {
    CustomError,
    UserNotFoundError,
    UserCreationError,
    UserUpdateError,
    UserDeletionError,
    UserInputValidationError,
    ProductNotFoundError,
    ProductCreationError,
    ClientNotFoundError,
    ClientCreationError,
    ClientUpdateError,
    ClientDeleteError,
    TransactionNotFoundError,
    TransactionCreationError,
    TransactionUpdateError,
    TransactionDeleteError,
    OrderNotFoundError,
    OrderCreationError,
    OrderUpdateError,
    OrderDeletionError,
    DeliveryStatusUpdateError,
    ProfitCreationError,
    ProfitRetrievalError,
    ProfitUpdateError,
    ProfitDeletionError,
    SettingsCreationError,
    SettingsNotFoundError,
    SettingsUpdateError,
    SettingsDeletionError,
    DatabaseError,
    RegistrationError,
    InvalidEmailError,
    InvalidPasswordError,
    IncorrectPasswordError,
    LoginError,
    LogoutError,
    TokenVerificationError,
    TokenNotFoundError,
    InvalidRefreshTokenError,
    RefreshTokenExpiredError,
    BackupCreationError,
    FetchBackupsError,
    FetchBackupByIdError,
    BackupUpdateError,
    BackupDeletionError,
    LogCreationError,
    FetchLogsError,
    FetchLogsByTypeError,
    FetchLogsByUserError,
    FetchLogsByModuleError,
    LogDeletionError,
    MetricsCreationError,
    FetchMetricsByDateError,
    FetchAllMetricsError,
    IncrementMetricsError,
    DeleteMetricsByDateError,
    FileRetrievalError,
    FileDeletionError,
    FileNotFoundError,
    ProfitAnalyticsError,
    ProductAnalyticsError,
    ClientAnalyticsError,
    OrderAnalyticsError,
    TransactionAnalyticsError,
    OrdersRetrievalByUserError,
    OrdersRetrievalByClientError,
    ProfitByIdNotFoundError,
    ProfitsByUserNotFoundError,
    ProfitsByProductNotFoundError,
    ProfitsByClientNotFoundError,
    DatabaseClearError,
    TokenError
} = require('./customErrors');

const errorHandler = (err, req, res, next) => {
    console.error(err);

    if (err instanceof CustomError) {
        // General custom error
        return res.status(400).json({ message: err.message });
    }

    // Not Found Errors
    if (
        err instanceof UserNotFoundError ||
        err instanceof ClientNotFoundError ||
        err instanceof ProductNotFoundError ||
        err instanceof TransactionNotFoundError ||
        err instanceof ProfitByIdNotFoundError ||
        err instanceof ProfitsByUserNotFoundError ||
        err instanceof ProfitsByProductNotFoundError ||
        err instanceof ProfitsByClientNotFoundError ||
        err instanceof OrderNotFoundError ||
        err instanceof SettingsNotFoundError ||
        err instanceof TokenNotFoundError ||
        err instanceof FileNotFoundError
    ) {
        return res.status(404).json({ message: err.message });
    }

    // Creation Errors
    if (
        err instanceof UserCreationError ||
        err instanceof ClientCreationError ||
        err instanceof ProductCreationError ||
        err instanceof TransactionCreationError ||
        err instanceof OrderCreationError ||
        err instanceof TokenError ||
        err instanceof ProfitCreationError ||
        err instanceof SettingsCreationError ||
        err instanceof RegistrationError ||
        err instanceof BackupCreationError ||
        err instanceof LogCreationError ||
        err instanceof MetricsCreationError
    ) {
        return res.status(500).json({ message: err.message });
    }

    // Update Errors
    if (
        err instanceof UserUpdateError ||
        err instanceof ClientUpdateError ||
        err instanceof TransactionUpdateError ||
        err instanceof OrderUpdateError ||
        err instanceof ProductUpdateError ||
        err instanceof DeliveryStatusUpdateError ||
        err instanceof ProfitUpdateError ||
        err instanceof SettingsUpdateError ||
        err instanceof BackupUpdateError ||
        err instanceof IncrementMetricsError
    ) {
        return res.status(500).json({ message: err.message });
    }

    // Deletion Errors
    if (
        err instanceof UserDeletionError ||
        err instanceof ClientDeleteError ||
        err instanceof TransactionDeleteError ||
        err instanceof ProductDeletionError ||
        err instanceof OrderDeletionError ||
        err instanceof ProfitDeletionError ||
        err instanceof SettingsDeletionError ||
        err instanceof BackupDeletionError ||
        err instanceof DatabaseClearError ||
        err instanceof LogDeletionError ||
        err instanceof DeleteMetricsByDateError ||
        err instanceof FileDeletionError
    ) {
        return res.status(500).json({ message: err.message });
    }

    // Database Errors
    if (
        err instanceof DatabaseError ||
        err instanceof RestoreFromBackupError ||
        err instanceof RecoveryError
    ) {
        return res.status(500).json({ message: err.message });
    }

    // Validation Errors
    if (err instanceof UserInputValidationError || err instanceof InvalidEmailError || err instanceof InvalidPasswordError) {
        return res.status(422).json({ message: err.message, errors: err.errors });
    }

    // Authentication Errors
    if (
        err instanceof IncorrectPasswordError ||
        err instanceof LoginError ||
        err instanceof LogoutError ||
        err instanceof TokenVerificationError ||
        err instanceof InvalidRefreshTokenError ||
        err instanceof RefreshTokenExpiredError
    ) {
        return res.status(401).json({ message: err.message });
    }

    // Retrieval Errors
    if (
        err instanceof ProfitRetrievalError ||
        err instanceof ProductRetrievalByIdError ||
        err instanceof ProductsRetrievalByOwnerError ||
        err instanceof FetchBackupsError ||
        err instanceof FetchBackupByIdError ||
        err instanceof BackupReadingError ||
        err instanceof BackupDataError ||
        err instanceof FetchLogsError ||
        err instanceof FetchLogsByTypeError ||
        err instanceof FetchLogsByUserError ||
        err instanceof FetchLogsByModuleError ||
        err instanceof FetchMetricsByDateError ||
        err instanceof FetchAllMetricsError ||
        err instanceof FileRetrievalError ||
        err instanceof ProfitAnalyticsError ||
        err instanceof ProductAnalyticsError ||
        err instanceof ClientAnalyticsError ||
        err instanceof OrderAnalyticsError ||
        err instanceof OrdersRetrievalByUserError ||
        err instanceof OrdersRetrievalByStatusError ||
        err instanceof OrdersRetrievalByClientError ||
        err instanceof TransactionAnalyticsError
    ) {
        return res.status(500).json({ message: err.message });
    }

    // If the error is not recognized, return a generic 500 error
    return res.status(500).json({ message: 'An unexpected error occurred.' });
};

module.exports = (err, req, res, next) => {
    let { statusCode, message } = err;

    switch (true) {
        case typeof err === 'string':
            // custom application error
            const is404 = err.toLowerCase().endsWith('not found');
            const status = is404 ? 404 : 400;
            return res.status(status).json({ message: err });

        case !!err.isBoom:
            // Boom errors
            return res.status(err.output.statusCode).json(err.output.payload);

        default:
            return res.status(statusCode || 500).json({ message: message || 'Internal Server Error' });
    }
};
