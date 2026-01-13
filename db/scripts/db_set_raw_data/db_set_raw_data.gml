// Feather disable all

/// Sets the raw data for a database, overwriting whatever was there already. Any data you
/// overwrite will be lost. This function will not set the "changed" state of the database and you
/// should handle that yourself with `db_set_changed()`.
/// 
/// @param database
/// @param data

function db_set_raw_data(_database, _data)
{
    _database.__data = _data;
}
