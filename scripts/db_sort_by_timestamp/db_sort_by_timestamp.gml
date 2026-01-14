// Feather disable all

/// Sorts an array of databases based on their timestamps. Set the `descending` parameter to `true`
/// to order from newest to oldest.
/// 
/// @param arrayOfDatabases
/// @param descending

function db_sort_by_timestamp(_array, _descending)
{
    if (_descending)
    {
        array_sort(_array, function(_a, _b)
        {
            return _a.__timestamp - _b.__timestamp;
        });
    }
    else
    {
        array_sort(_array, function(_a, _b)
        {
            return _b.__timestamp - _a.__timestamp;
        });
    }
}
