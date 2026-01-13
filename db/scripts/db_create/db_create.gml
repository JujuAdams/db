// Feather disable all

/// Creates a new, empty database and returns it. The timestamp will be set to the current local
/// time (using `date_current_datetime()`).

function db_create()
{
    return new __db_class();
}
