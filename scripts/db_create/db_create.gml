// Feather disable all

/// Creates a new, empty database and returns it. The timestamp will be set to the current local
/// time (using `date_current_datetime()`).
/// 
/// You may optionally provide initial data. You may also provide a default data template. Please
/// see `db_set_default_data()` for an explanation of the expected format for the default data.
/// 
/// @param [initialData=undefined]
/// @param [defaultData=undefined]

function db_create(_initialData = undefined, _defaultData = undefined)
{
    return new __db_class(_initialData, _defaultData);
}
