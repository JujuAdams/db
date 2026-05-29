// Feather disable all

/// Returns the default data template stored inside a database, as set by `db_set_default_data()`.
/// 
/// @param database

function db_get_default_data(_database)
{
    return _database.__defaultData;
}
