// Feather disable all

/// Sets the timestamp for a database. You should typically call this function immediately before saving a database.
/// 
/// @param database
/// @param timestamp

function db_set_timestamp(_database, _timestamp)
{
    _database.__timestamp = _timestamp;
}
