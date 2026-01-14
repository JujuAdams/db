// Feather disable all

/// Returns the raw data structure stored inside a database. This will be nested struct/array
/// collection of some kind, depending on what values you've set.
/// 
/// @param database

function db_get_raw_data(_database)
{
    return _database.__data;
}
