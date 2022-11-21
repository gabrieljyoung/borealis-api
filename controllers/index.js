/**
 * CONTROLLERS FILE
 * Contains functions that are called by routers. SQL queries are defined here.
 * Referenced by routes/index.js (the router file).
 */

const AppError = require("../utils/appError");
const conn = require("../services/db");

exports.getAllSections = (req, res, next) => {

	conn.query(
		"SELECT * FROM sections",

		function (err, data, fields) {

			if (err) return next(new AppError(err));

			res.status(200).json({
				status: "success",
				length: data.length,
				data: data,
			});
		}
	);
};


exports.createSection = (req, res, next) => {

	// TODO: body will never not exist, it's always {}
	if (!req.body) return next(new AppError("No form data found", 404));

	conn.query(
		"INSERT INTO sections (temp_desc) VALUE (?)",
		[req.body.name], // name is the course code (col. temp_desc)

		function (err, data, fields) {

			if (err) return next(new AppError(err, 500));

			res.status(201).json({
				status: "success",
				message: "section created!",
			});
		}
	);
};


exports.getSection = (req, res, next) => {

	if (!req.params.id) {
		return next(new AppError("No section ID found", 404));
	}

	conn.query(
		"SELECT * FROM sections WHERE id = ?",
		[req.params.id],
		function (err, data, fields) {
			if (err) return next(new AppError(err, 500));
			res.status(200).json({
				status: "success",
				length: data.length,
				data: data,
			});
		}
	);
};


exports.updateSection = (req, res, next) => {
	if (!req.params.id) {
		return next(new AppError("No section ID found", 404));
	}
	else if (!req.body.name) {
		return next(new AppError("No new section name found", 404));
	}

	conn.query(
		"UPDATE sections SET temp_desc=? WHERE id=?",
		[req.body.name, req.params.id],
		function (err, data, fields) {
			if (err) return next(new AppError(err, 500));
			res.status(201).json({
				status: "success",
				message: "section updated!",
			});
		}
	);
};



exports.deleteSection = (req, res, next) => {

	if (!req.params.id) {
		return next(new AppError("No section ID found", 404));
	}

	conn.query(
		"DELETE FROM sections WHERE id=?",
		[req.params.id],
		function (err, fields) {
			if (err) return next(new AppError(err, 500));
			res.status(201).json({
				status: "success",
				message: "section deleted!",
			});
		}
	);
}
