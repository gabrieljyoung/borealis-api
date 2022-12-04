/**
 * MAIN APPLICATION FILE
 */

const express = require("express");
const bodyParser = require("body-parser")
const router = require("./routes");
const AppError = require("./utils/appError");
const errorHandler = require("./utils/errorHandler");

const app = express()
const PORT = 3000;


// Middleware to parse body of requests
app.use(bodyParser.json())

// Import API routes from routes/index.js
app.use('/', router);

// 404 anything that falls through the routes in router
app.all("*", (req, res, next) => {
    next(new AppError(`The URL ${req.originalUrl} does not exist`, 404));
});

// Handle any errors from router or 404 above, and send response
app.use(errorHandler);


const server = app.listen(PORT, () => {
    console.log(`server running on port ${PORT}`);
});

