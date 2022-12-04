/**
 * ROUTER FILE
 * Defines API endpoints, and maps them to their corresponding
 * middleware functions (see controllers/index.js).
 */


const express = require("express");
const controllers = require("../controllers");
const router = express.Router();


router
    .route("/courses")
    .get(controllers.getAllCourses)
    .post(controllers.createCourse);    // admin only

router
    .route("/courses/:id")
    .get(controllers.getCourse)
    .put(controllers.updateCourse)      // admin only
    .delete(controllers.deleteCourse);  // admin only

router
    .route("/sections")
    .get(controllers.getAllSections)
    .post(controllers.createSection);   // admin only

router
    .route("/sections/:id")
    .get(controllers.getSection)
    .put(controllers.updateSection)     // admin only
    .delete(controllers.deleteSection); // admin only
    
module.exports = router;

