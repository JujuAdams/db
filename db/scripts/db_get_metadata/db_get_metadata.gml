// Feather disable all

/// Returns the metadata associated with a database as set by `db_set_metadata()`.
/// 
/// @param database

function db_get_metadata(_database)
{
    return _database.__metadata;
}
