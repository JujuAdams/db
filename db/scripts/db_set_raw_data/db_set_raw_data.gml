// Feather disable all

/// Sets the raw data for a database. This can be used to overwrite the contents of a database.
/// 
/// @param database
/// @param data
/// @param [setChanged=false]

function db_set_raw_data(_database, _data, _set_changed = false)
{
    _database.__data = _data;
    if (_set_changed) _database.__changed = true;
}
