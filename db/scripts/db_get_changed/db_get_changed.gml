// Feather disable all

/// Returns if a database has been changed since the last time this function was called. This
/// function will automatically clear the changed state for the database when called. If you'd like
/// the changed state to persist, set the optional `reset` parameter to `false`.
/// 
/// @param database
/// @param [resetState=true]

function db_get_changed(_database, _reset = true)
{
    var _return = _database.__changed;
    if (_reset) _database.__changed = false;
    return _return;
}
