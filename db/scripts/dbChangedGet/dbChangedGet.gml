/// @param database
/// @param [resetState=true]

function DbChangedGet(_database, _reset = true)
{
    var _return = _database.__changed;
    if (_reset) _database.__changed = false;
    return _return;
}