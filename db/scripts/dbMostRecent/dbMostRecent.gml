/// @param arrayOfDatabases
/// @param [returnIndex=false]

function dbMostRecent(_array, _returnIndex = false)
{
    var _max_database = undefined;
    var _max_index    = undefined;
    var _maxTimestamp = -infinity;
    
    var _i = 0;
    repeat(array_length(_array))
    {
        var _database = _array[_i];
        if (_database.__timestamp > _maxTimestamp)
        {
            _max_database = _database;
            _max_index    = _i;
            _maxTimestamp = _database.__timestamp;
        }
        
        ++_i;
    }
    
    return _returnIndex? _max_index : _maxTimestamp;
}