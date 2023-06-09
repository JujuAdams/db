/// @param database
/// @param state

function dbChangedSet(_database, _state)
{
    _database.__changed = _state;
    if (_state) _database.__timestamp = date_current_datetime();
}