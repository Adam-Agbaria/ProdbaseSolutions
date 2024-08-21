// customErrors.js

class CustomError extends Error {
    constructor(message) {
        super(message);
        this.name = this.constructor.name;
    }
}

// User related errors
class UserCreationError extends CustomError {
    constructor(message = "Error creating user.") {
        super(message);
    }
}

class UserNotFoundError extends CustomError {
    constructor(id) {
        super(`User with id ${id} not found.`);
    }
}

class UserUpdateError extends CustomError {
    constructor(id) {
        super(`Error updating user with id ${id}.`);
    }
}

class UserDeletionError extends CustomError {
    constructor(id) {
        super(`Error deleting user with id ${id}.`);
    }
}

class UserInputValidationError extends CustomError {
    constructor(errors) {
        super(`User input validation error.`);
        this.errors = errors;
    }
}

// Product related errors
class ProductNotFoundError extends CustomError {
    constructor() {
        super("Product not found.");
    }
}

class ProductCreationError extends CustomError {
    constructor() {
        super("Error while creating product.");
    }
}

class ProductRetrievalByIdError extends CustomError {
    constructor(productId) {
        super(`Failed to retrieve product with ID: ${productId}`);
    }
}

class ProductUpdateError extends CustomError {
    constructor(productId) {
        super(`Failed to update product with ID: ${productId}`);
    }
}

class ProductDeletionError extends CustomError {
    constructor(productId) {
        super(`Failed to delete product with ID: ${productId}`);
    }
}

class ProductsRetrievalByOwnerError extends CustomError {
    constructor(ownerId) {
        super(`Failed to retrieve products for owner with ID: ${ownerId}`);
    }
}

// Client related errors
class ClientNotFoundError extends CustomError {
    constructor() {
        super("Client not found.");
    }
}

class ClientCreationError extends CustomError {
    constructor() {
        super("Error while creating client.");
    }
}

class ClientUpdateError extends CustomError {
    constructor() {
        super("Error while updating client.");
    }
}

class ClientDeleteError extends CustomError {
    constructor() {
        super("Error while deleting client.");
    }
}

// Transaction related errors
class TransactionNotFoundError extends CustomError {
    constructor() {
        super("Transaction not found.");
    }
}

class TransactionCreationError extends CustomError {
    constructor() {
        super("Error while creating transaction.");
    }
}

class TransactionUpdateError extends CustomError {
    constructor() {
        super("Error while updating transaction.");
    }
}

class TransactionDeleteError extends CustomError {
    constructor() {
        super("Error while deleting transaction.");
    }
}

// Order related errors
class OrderCreationError extends CustomError {
    constructor(message = "Error creating order.") {
        super(message);
    }
}

class OrderNotFoundError extends CustomError {
    constructor(orderId) {
        super(`Order with id ${orderId} not found.`);
    }
}

class OrderUpdateError extends CustomError {
    constructor(orderId) {
        super(`Error updating order with id ${orderId}.`);
    }
}

class OrderDeletionError extends CustomError {
    constructor(orderId) {
        super(`Error deleting order with id ${orderId}.`);
    }
}

class OrdersRetrievalByUserError extends CustomError {
    constructor(userId) {
        super(`Failed to retrieve orders for user with ID: ${userId}`);
    }
}

class OrdersRetrievalByStatusError extends CustomError {
    constructor(status) {
        super(`Failed to retrieve orders with status: ${status}`);
    }
}

class OrdersRetrievalByClientError extends CustomError {
    constructor(clientId) {
        super(`Failed to retrieve orders for client with ID: ${clientId}`);
    }
}

class DeliveryStatusUpdateError extends CustomError {
    constructor(orderId) {
        super(`Error updating delivery status for order with id ${orderId}.`);
    }
}

// Profit-related errors
class ProfitCreationError extends CustomError {
    constructor(message = "Failed to create profit entry.") {
        super(message);
    }
}

class ProfitRetrievalError extends CustomError {
    constructor(message = "Failed to retrieve profit entry.") {
        super(message);
    }
}

class ProfitByIdNotFoundError extends CustomError {
    constructor(profitId) {
        super(`Error fetching profit with ID: ${profitId}`);
    }
}

class ProfitsByUserNotFoundError extends CustomError {
    constructor(userId) {
        super(`Error fetching profits for user with ID: ${userId}`);
    }
}

class ProfitsByProductNotFoundError extends CustomError {
    constructor(productId) {
        super(`Error fetching profits for product with ID: ${productId}`);
    }
}

class ProfitsByClientNotFoundError extends CustomError {
    constructor(clientId) {
        super(`Error fetching profits for client with ID: ${clientId}`);
    }
}

class ProfitUpdateError extends CustomError {
    constructor(profitId) {
        super(`Error updating profit with ID: ${profitId}`);
    }
}

class ProfitDeletionError extends CustomError {
    constructor(profitId) {
        super(`Error deleting profit with ID: ${profitId}`);
    }
}

// Settings related errors
class SettingsCreationError extends CustomError {
    constructor(message = "Error creating settings.") {
        super(message);
    }
}

class SettingsNotFoundError extends CustomError {
    constructor(userId) {
        super(`Settings for user with id ${userId} not found.`);
    }
}

class SettingsUpdateError extends CustomError {
    constructor(userId) {
        super(`Error updating settings for user with id ${userId}.`);
    }
}

class SettingsDeletionError extends CustomError {
    constructor(userId) {
        super(`Error deleting settings for user with id ${userId}.`);
    }
}


// Other generic database related errors can be added as needed
class DatabaseError extends CustomError {
    constructor() {
        super("Database operation failed.");
    }
}

// Authentication related errors
class RegistrationError extends CustomError {
    constructor(message = "Registration failed.") {
        super(message);
    }
}

class InvalidEmailError extends CustomError {
    constructor() {
        super("Invalid email address.");
    }
}

class InvalidPasswordError extends CustomError {
    constructor() {
        super("Invalid password.");
    }
}

class IncorrectPasswordError extends CustomError {
    constructor() {
        super("Incorrect password.");
    }
}

class LoginError extends CustomError {
    constructor(message = "Login failed.") {
        super(message);
    }
}

class LogoutError extends CustomError {
    constructor(message = "Logout failed.") {
        super(message);
    }
}

// JWT related errors
class TokenError extends CustomError {
    constructor(message = "Token generation failed.") {
        super(message);
    }
}

class TokenVerificationError extends CustomError {
    constructor(message = "Token verification failed.") {
        super(message);
    }
}

class TokenNotFoundError extends CustomError {
    constructor() {
        super("No token provided.");
    }
}

class InvalidRefreshTokenError extends CustomError {
    constructor() {
        super("Invalid refresh token.");
    }
}

class RefreshTokenExpiredError extends CustomError {
    constructor() {
        super("Refresh token has expired.");
    }
}

// Backup related errors
class BackupCreationError extends CustomError {
    constructor(message = "Error creating backup.") {
        super(message);
    }
}

class FetchBackupsError extends CustomError {
    constructor(message = "Error fetching backups.") {
        super(message);
    }
}

class FetchBackupByIdError extends CustomError {
    constructor(message = "Error fetching backup.") {
        super(message);
    }
}

class BackupUpdateError extends CustomError {
    constructor(message = "Error updating backup status.") {
        super(message);
    }
}

class BackupDeletionError extends CustomError {
    constructor(message = "Error deleting backup.") {
        super(message);
    }
}

// Log related errors
class LogCreationError extends CustomError {
    constructor(message = "Error creating log.") {
        super(message);
    }
}

class FetchLogsError extends CustomError {
    constructor(message = "Error fetching logs.") {
        super(message);
    }
}

class FetchLogsByTypeError extends CustomError {
    constructor(logType, message = `Error fetching logs of type ${logType}.`) {
        super(message);
    }
}

class FetchLogsByUserError extends CustomError {
    constructor(userId, message = `Error fetching logs for user ${userId}.`) {
        super(message);
    }
}

class FetchLogsByModuleError extends CustomError {
    constructor(moduleType, message = `Error fetching logs for module ${moduleType}.`) {
        super(message);
    }
}

class LogDeletionError extends CustomError {
    constructor(message = "Error deleting log.") {
        super(message);
    }
}

// Metrics related errors
class MetricsCreationError extends CustomError {
    constructor(message = "Error creating metrics.") {
        super(message);
    }
}

class FetchMetricsByDateError extends CustomError {
    constructor(date, message = `Error fetching metrics for date ${date}.`) {
        super(message);
    }
}

class FetchAllMetricsError extends CustomError {
    constructor(message = "Error fetching all metrics.") {
        super(message);
    }
}

class IncrementMetricsError extends CustomError {
    constructor(message = "Error incrementing metric.") {
        super(message);
    }
}

class DeleteMetricsByDateError extends CustomError {
    constructor(date, message = `Error deleting metrics for date ${date}.`) {
        super(message);
    }
}

// File storage-related errors
class FileRetrievalError extends CustomError {
    constructor(message = "Failed to retrieve the file.") {
        super(message);
    }
}

class FileDeletionError extends CustomError {
    constructor(message = "Failed to delete the file.") {
        super(message);
    }
}

class FileNotFoundError extends CustomError {
    constructor(message = "File not found.") {
        super(message);
    }
}

//Recovery Errors
class DatabaseClearError extends CustomError {
    constructor(message = "Failed to clear the database.") {
        super(message);
    }
}

class BackupReadingError extends CustomError {
    constructor(message = "Error reading the backup file.") {
        super(message);
    }
}

class BackupDataError extends CustomError {
    constructor(message = "Backup data is empty or invalid.") {
        super(message);
    }
}

class RestoreFromBackupError extends CustomError {
    constructor(message = "Failed to restore from the backup.") {
        super(message);
    }
}

class RecoveryError extends CustomError {
    constructor(message = "Recovery process failed.") {
        super(message);
    }
}


// Analytics-specific errors
class ProfitAnalyticsError extends CustomError {
    constructor(message = "Failed to retrieve profit analytics.") {
        super(message);
    }
}

class ProductAnalyticsError extends CustomError {
    constructor(message = "Failed to retrieve product analytics.") {
        super(message);
    }
}

class ClientAnalyticsError extends CustomError {
    constructor(message = "Failed to retrieve client analytics.") {
        super(message);
    }
}

class OrderAnalyticsError extends CustomError {
    constructor(message = "Failed to retrieve order analytics.") {
        super(message);
    }
}

class TransactionAnalyticsError extends CustomError {
    constructor(message = "Failed to retrieve transaction analytics.") {
        super(message);
    }
}


module.exports = {
    CustomError,
    UserNotFoundError,
    UserCreationError,
    UserUpdateError,
    UserDeletionError,
    UserInputValidationError,
    ClientNotFoundError,
    ClientCreationError,
    ClientUpdateError,
    ClientDeleteError,
    ProductNotFoundError,
    ProductCreationError,
    ProductRetrievalByIdError,
    ProductsRetrievalByOwnerError,
    ProductUpdateError,
    ProductDeletionError,
    TransactionNotFoundError,
    TransactionCreationError,
    TransactionUpdateError,
    TransactionDeleteError,
    OrderNotFoundError,
    OrderCreationError,
    OrderUpdateError,
    OrderDeletionError,
    OrdersRetrievalByUserError,
    OrdersRetrievalByStatusError,
    OrdersRetrievalByClientError,
    DeliveryStatusUpdateError,
    ProfitCreationError,
    ProfitRetrievalError,
    ProfitUpdateError,
    ProfitDeletionError,
    ProfitByIdNotFoundError,
    ProfitsByUserNotFoundError,
    ProfitsByProductNotFoundError,
    ProfitsByClientNotFoundError,
    RegistrationError,
    InvalidEmailError,
    InvalidPasswordError,
    IncorrectPasswordError,
    LoginError,
    LogoutError,
    TokenError,
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
    BackupCreationError,
    DatabaseClearError,
    BackupReadingError,
    BackupDataError,
    RestoreFromBackupError,
    RecoveryError,
    ProfitAnalyticsError,
    ProductAnalyticsError,
    ClientAnalyticsError,
    OrderAnalyticsError,
    TransactionAnalyticsError,
    SettingsCreationError,
    SettingsNotFoundError,
    SettingsUpdateError,
    SettingsDeletionError,
    DatabaseError
};


