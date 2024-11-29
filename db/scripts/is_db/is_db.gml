// Feather disable all

/// Returns whether a value is a database created by `db_create()` (or another db function that returns a database).
/// 
/// @param value

function is_db(_value)
{
    return (is_struct(_value) && (instanceof(_value) == "__db_class"));
}
