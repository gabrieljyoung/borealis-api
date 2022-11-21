const express = require("express");
//const cors = require("cors");
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

// Check for missing URLs and throw 404 error
app.all("*", (req, res, next) => {
	next(new AppError(`The URL ${req.originalUrl} does not exist`, 404));
});

app.use(errorHandler);


app.listen(PORT, () => {
	console.log(`server running on port ${PORT}`);
});

module.exports = app;

