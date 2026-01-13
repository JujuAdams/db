// Feather disable all

/// Creates a deep copy of a database and returns it. The new database will copy metadata, the
/// timestamp and changed state.
/// 
/// @param database

function db_duplicate(_database)
{
    var _new = new __db_class();
    
    _new.__metadata  = variable_clone(_database.__metadata);
    _new.__data      = variable_clone(_database.__data    );
    _new.__changed   = _database.__changed;
    _new.__timestamp = _database.__timestamp;
    
    return _new;
}
