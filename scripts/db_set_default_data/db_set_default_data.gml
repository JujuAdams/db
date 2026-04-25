// Feather disable all

/// Sets the default data template for a database, overwriting whatever default data was previously
/// set. This function will not set the "changed" state of the database. Default values that you
/// set with this function can be returned by `db_default()` and `db_read()`.
/// 
/// The default data template should follow a specific format.
/// 
/// @param database
/// @param defaultData

function db_set_default_data(_database, _defaultData)
{
    _database.__defaultData = _defaultData;
}
