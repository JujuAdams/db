// Feather disable all

/// Returns a string that describes the database, including its timestamp, changed state, metadata
/// and contents. This string can be quite large. You should not use this function to save data
/// to device storage.
/// 
/// @param database

function db_get_debug_string(_database)
{
    return $"{string(_database)}\nchanged = {_database.__changed? "true" : "false"}\ntimestamp = {date_datetime_string(_database.__timestamp)} ({string_format(_database.__timestamp, 0, 10)})\nmetadata = {json_stringify(_database.__metadata, true)}\ndata = {json_stringify(_database.__data, true)}";
}
