const winston = require('winston');
const DailyRotateFile = require('winston-daily-rotate-file');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    // Write all logs error level and below to `error.log`
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    // Write to all logs with level `info` and below to `combined.log` 
    new winston.transports.File({ filename: 'logs/combined.log' }),
  ],
});

// If we're not in production, log to the `console` with the format:
// `${info.level}: ${info.message} JSON.stringify({ ...rest }) `
if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple(),
  }));
}


logger.add(new DailyRotateFile({
  filename: 'logs/application-%DATE%.log',
  datePattern: 'YYYY-MM-DD',
  maxSize: '20m',
  maxFiles: '14d'
}));

format: winston.format.combine(
    winston.format.timestamp({
      format: 'YYYY-MM-DD HH:mm:ss'
    }),
    winston.format.json()
  )

function formatError(err) {
return `${err.stack || err}`;
}

// logger.error(formatError(new Error("Something went wrong!")));

winston.exceptions.handle(
    new winston.transports.File({ filename: 'logs/exceptions.log' })
  );
  
  process.on('unhandledRejection', (reason, promise) => {
    throw reason;
  });

const ignorePrivate = winston.format((info) => {
if (info.private) { return false; }
return info;
});

format: winston.format.combine(
ignorePrivate(),
winston.format.json()
)
  
  

module.exports = logger;
