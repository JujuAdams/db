/// @param database
/// @param [resetState=true]

function dbChangedGet(_database, _reset = true)
{
    var _return = _database.__changed;
    if (_reset) _database.__changed = false;
    return _return;
}