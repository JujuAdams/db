// Feather disable all

/// Creates a new, empty database and returns it. The timestamp will be set to the current local
/// time (using `date_current_datetime()`). You may specify some initial data.
/// 
/// @param [initialData=undefined]

function db_create(_initialData = undefined)
{
    return new __db_class(_initialData);
}
