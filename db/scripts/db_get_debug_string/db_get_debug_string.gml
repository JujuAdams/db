// Feather disable all

/// @param database

function db_get_debug_string(_database)
{
    return $"{string(_database)}:\ndb save version = {DB_SAVE_VERSION}\ntimestamp = {date_datetime_string(_database.__timestamp)} ({string_format(_database.__timestamp, 0, 10)})\nmetadata = {json_stringify(_database.__metadata, true)}\ndata = {json_stringify(_database.__data, true)}";
}
