// Feather disable all

/// Sets the default data template for a database, overwriting whatever default data was previously
/// set. This function will not set the "changed" state of the database. Default values that you
/// set with this function can be returned by `db_default()` and `db_read_then_default()`.
/// 
/// The default data template should follow the same structure as the data you're reading and
/// writing i.e. nested structs and arrays.
/// 
/// Arrays data is presumed to be homogenous. This is a fancy way of saying that there should be no
/// difference in default values between members of an array.
/// 
/// The variable name `_CATCH_` may be used as a fallback variable name for structs. This fallback
/// value will be used if a variable name in a struct cannot be found. This if helpful for structs
/// that are being used as dictionaries.
/// 
/// @param database
/// @param defaultData

function db_set_default_data(_database, _defaultData)
{
    _database.__defaultData = _defaultData;
}
