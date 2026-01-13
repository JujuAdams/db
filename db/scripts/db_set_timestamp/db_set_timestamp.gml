// Feather disable all

/// Sets the timestamp for a database. You should typically call this function immediately before
/// saving a database. If you don't specify the timestamp, which is an optional parameter, then the
/// value returned by `date_current_datetime()` will be used (which is the local time for the
/// player).
/// 
/// @param database
/// @param [timestamp]

function db_set_timestamp(_database, _timestamp = date_current_datetime())
{
    _database.__timestamp = _timestamp;
}
