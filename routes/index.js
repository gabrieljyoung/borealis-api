/**
 * ROUTER FILE
 * Maps API routes and HTTP request types to functions (see controllers/index.js).
 * Imported into the main app script, see app.js.
 */


const express = require("express");
const controllers = require("../controllers");
const router = express.Router();

router
	.route("/")
	.get(controllers.getAllSections)
	.post(controllers.createSection);

router
	.route("/:id")
	.get(controllers.getSection)
	.put(controllers.updateSection)
	.delete(controllers.deleteSection);
	
module.exports = router;

