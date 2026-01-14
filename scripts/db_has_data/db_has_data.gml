// Feather disable all

/// Returns whether a database contains any data.
/// 
/// @param database

function db_has_data(_database)
{
    return (_database.__data != undefined);
}
