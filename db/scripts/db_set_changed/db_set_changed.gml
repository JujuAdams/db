/// @param database
/// @param state

function db_set_changed(_database, _state)
{
    _database.__changed = _state;
}