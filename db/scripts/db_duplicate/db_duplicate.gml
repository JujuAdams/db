// Feather disable all

/// Creates a deep copy of a database and returns it.
/// 
/// @param database
/// @param [fastMode=true]

function db_duplicate(_database, _fast_mode = false)
{
    var _new = new __db_class();
    
    if (_fast_mode)
    {
        _new.__metadata = variable_clone(_database.__metadata);
        _new.__data     = variable_clone(_database.__data    );
    }
    else
    {
        _new.__metadata = __db_deep_copy(_database.__metadata);
        _new.__data     = __db_deep_copy(_database.__data    );
    }
    
    _new.__changed  = _database.__changed;
    return _new;
}
