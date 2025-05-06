
/**
 * Parses body of request to generate filter conditions in valid SQL format.
 * Sets req.filters to one string containing all appropriate conditions, to
 * be incorporated into a database query by subsequent request handler functions.
 */

exports.parseFiltersFromBody = (req, res, next) => {
    
    let out = [];

    if (req.body.include) {
        // API response data MUST fulfill ALL conditions under include
        out.push(parseFilterData(req.body.include, true));
    }
    if (req.body.exclude) {
        // API response data MUST NOT fulfill ANY condition under exclude
        out.push(parseFilterData(req.body.exclude, false));
    }

    req.filters = out.join(" AND ");
    next();
};


/**
 * Parses an object with filter types as tags (e.g. times, locations, instructors)
 * into a valid SQL expression.
 * 
 * @param filterData    A JS object with named tags representing filters to
 *                        apply to data when retrieving from database.
 * @param include       Boolean representing whether data meeting the conditions
 *                        in filterData should be included (true) or excluded (false)
 *                        in/from the API response.
 * @returns             A valid SQL expression containing all given conditions, combined as
 *                        (p1 AND p2 AND p3...) if include = true, otherwise as
 *                        NOT (p1 OR p2 OR p3...).
 */
const parseFilterData = function (filterData, include) {

    let out = [];

    // Parse filters relating to section times
    if (filterData.times) {
        out.push(parseTimeFilters(filterData.times, include));
    }

    // More filters coming soon...


    // Join all conditions into one string
    if (include)
        return out.join(' AND ');
    else
        return `NOT ( ${out.join('OR')} )`;
}


/**
 * Parses weekday and time filters into a valid SQL expression.
 * 
 * @param timeFilters   A list of objects of the form {day, from, to}, where each tag
 *                        is optional.
 * @param include       Boolean value representing whether sections in the specified
 *                        time windows should be included (true) or excluded (false)
 *                        from response data.
 * @returns             A valid SQL expression representing all given conditions. If multiple
 *                        time windows are provided, a section need only fall into one of them
 *                        to be included/excluded (the comparisons defining each time window are
 *                        joined by logical OR)
 */
const parseTimeFilters = function(timeFilters, include) {

    var fromComparison;
    var toComparison;

    /* Include mode:
       "include from" means "must start at or after", and "include to" means "must end at or before" */
    if (include) {
        fromComparison = "start_time >="
        toComparison   = "end_time <="
    }
    /* Exclude mode:
       "exclude from" means "cannot end after", and "exclude to" means "cannot start before" */
    else {
        fromComparison = "end_time >"
        toComparison   = "start_time <"
    }

    let out = [];

    timeFilters.forEach(timeFilter => {
        // a timeFilter has structure {day, from, to}, with each element being optional

        let allConditions = [];

        // Convert comma-delimited list of weekdays to list delimited and bookended with % symbols
        // (for MySQL to match any sections containing at least these weekdays)
        if (timeFilter.days) {
            let daysList = timeFilter.days.split(',');
            allConditions.push(`weekdays LIKE '%${daysList.join("%")}%'`);
        }

        let timeConditions = [];

        // Construct appropriate expressions for the given 'from' and 'to' tags
        if (timeFilter.from)
            timeConditions.push(`${fromComparison} "${timeFilter.from}"`);

        if (timeFilter.to)
            timeConditions.push(`${toComparison} "${timeFilter.to}"`);

        if (timeFilter.from && timeFilter.to) {
            // Join time conditions, if there are two (from and to)
            if (timeFilter.from < timeFilter.to) {
                allConditions.push(timeConditions.join(" AND "));
            } else {
                allConditions.push(timeConditions.join(" OR "));
            }
        }
        else // No need to join time conditions if there is only one (from or to)
            allConditions.push(timeConditions);

        
        // Join weekday condition with time condition(s)
        out.push(`(${allConditions.join(" AND ")})`);
        
    });

    // Return formatted date/time conditions joined by OR
    return `(${out.join(" OR ")})`;
    
}

