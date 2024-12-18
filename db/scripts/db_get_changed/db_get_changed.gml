// Feather disable all

/// Returns if a database has been changed since the last time this function was called.
/// 
/// @param database
/// @param [resetState=true]

function db_get_changed(_database, _reset = true)
{
    var _return = _database.__changed;
    if (_reset) _database.__changed = false;
    return _return;
}
