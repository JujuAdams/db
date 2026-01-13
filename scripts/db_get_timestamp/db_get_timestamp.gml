// Feather disable all

/// Returns the timestamp for a database, as set by `db_set_timestamp()`.
/// 
/// @param database

function db_get_timestamp(_database)
{
    return _database.__timestamp;
}
