/// @param arrayOfDatabases
/// @param mostRecent

function dbSortByTimestamp(_array, _mostRecent)
{
    if (_mostRecent)
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