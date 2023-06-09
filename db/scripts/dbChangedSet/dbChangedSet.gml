/// @param database
/// @param state

function DbChangedSet(_database, _state)
{
    _database.__changed = _state;
    if (_state) _database.__timestamp = date_current_datetime();
}