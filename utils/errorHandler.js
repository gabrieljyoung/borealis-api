/**
 * GENERAL PURPOSE ERROR HANDLER
 * Catches any errors arising from earlier in the middleware stack
 * and ends the request-response cycle by sending an error message
 * to the client. Overrides the default Express.js error handler.
 */


module.exports = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500;
    err.status = err.status || "Error";
    res.status(err.statusCode).json({
        status: err.status,
        message: err.message,
    });
};
