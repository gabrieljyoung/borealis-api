/**
 * CONTROLLERS FILE
 * Contains middleware functions for each API endpoint. SQL queries are defined here.
 * Refer to router file (routes/index.js) for the mapping of endpoints to functions.
 */

const AppError = require("../utils/appError");
const db = require("../services/db");


/*********************************
 Courses - user operations
**********************************/

// GET from /courses
exports.getAllCourses = (req, res, next) => {

    db.query(
        // View defined to get all course info plus the number of sections for each
        "SELECT * FROM get_all_courses",

        function (err, data, fields) {

            if (err) return next(new AppError(err));

            res.status(200).json({
                status: "Success",
                length: data.length,
                data: data,
            });
        }
    );
};

// GET from /courses/<id>
exports.getCourse = (req, res, next) => {

    db.query(
        "SELECT * FROM get_all_courses WHERE code = ?",
        [req.params.id],

        function (err, data, fields) {

            if (err) // database query error
                return next(new AppError(err));

            if (data.length == 0) // query succeeded but returned empty set
                return next(new AppError("Course not found.", 404));

            res.status(200).json({
                status: "Success",
                length: data.length,
                data: data,
            });
        }
    );
};


/*********************************
 Courses - admin operations
**********************************/

// POST to /courses
exports.createCourse = (req, res, next) => {

    if (!req.body.code || !req.body.name) {
        return next(new AppError("Cannot create new course without a code and a name.", 400));
    }

    db.query(
        "INSERT INTO courses VALUES (?, ?, ?, ?)",
        [req.body.code, req.body.name, req.body.descr, req.body.credits],

        function (err, data, fields) {
            if (err) return next(new AppError(err));
            res.status(201).json({
                status: "Success",
                message: "Course created!",
            });
        }
    );
};


// PUT to /courses/<id>
exports.updateCourse = (req, res, next) => {

    if (!req.body.name) {
        return next(new AppError("Cannot update course without specifying a new name.", 400));
    }

    db.query(
        "UPDATE courses SET name=?, descr=?, credits=? WHERE code=?",
        [req.body.name, req.body.descr, req.body.credits, req.params.id],

        function (err, data, fields) {
            if (err) return next(new AppError(err));
            res.status(201).json({
                status: "Success",
                message: "Course updated!",
            });
        }
    );
};


// DELETE from /courses/<id>
exports.deleteCourse = (req, res, next) => {

    db.query(
        "DELETE FROM courses WHERE code=?",
        [req.params.id],

        function (err, fields) {
            if (err) return next(new AppError(err));
            res.status(200).json({
                status: "Success",
                message: "Course deleted!",
            });
        }
    );
}


/*********************************
 Sections - user operations
**********************************/

// GET from /sections
exports.getAllSections = (req, res, next) => {

    db.query(
        // View defined to get non-redundant info about sections, plus the associated course name
        "SELECT * FROM get_all_sections",

        function (err, data, fields) {

            if (err) return next(new AppError(err));

            res.status(200).json({
                status: "Success",
                length: data.length,
                data: data,
            });
        }
    );
};


// GET from /sections/<id>
exports.getSection = (req, res, next) => {

    db.query(
        "SELECT * FROM get_all_sections WHERE id = ?",
        [req.params.id],

        function (err, data, fields) {

            if (err) return next(new AppError(err));

            res.status(200).json({
                status: "Success",
                length: data.length,
                data: data,
            });
        }
    );
};


/*********************************
 Sections - admin operations
**********************************/

// POST to /sections
exports.createSection = (req, res, next) => {


    db.query(
        // TODO: Find a way to clean this up
        "INSERT INTO sections (course_code, type, num, start_date, end_date, start_time, end_time, weekdays) VALUES (?,?,?,?,?,?,?,?)",
        [req.body.course_code, req.body.type, req.body.num, req.body.start_date, req.body.end_date,
            req.body.start_time, req.body.end_time, req.body.weekdays],

        function (err, data, fields) {

            if (err) return next(new AppError(err, 500));

            res.status(201).json({
                status: "Success",
                message: "Section created!",
            });
        }
    );
};


// PUT to /sections/<id>
exports.updateSection = (req, res, next) => {

    db.query(
        "UPDATE sections SET start_date=?, end_date=?, start_time=?, end_time=?, weekdays=? WHERE section_code=?",
        [req.body.start_date, req.body.end_date, req.body.start_time, req.body.end_time, req.body.weekdays, req.params.id],

        function (err, data, fields) {

            if (err) return next(new AppError(err, 500));

            res.status(201).json({
                status: "Success",
                message: "Section updated!",
            });
        }
    );
};


// DELETE from /sections/<id>
exports.deleteSection = (req, res, next) => {

    db.query(
        "DELETE FROM sections WHERE section_code=?",
        [req.params.id],

        function (err, fields) {

            if (err) return next(new AppError(err, 500));

            res.status(200).json({
                status: "Success",
                message: "Section deleted!",
            });
        }
    );
}
