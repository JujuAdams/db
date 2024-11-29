// Feather disable all

/// Sets the "changed" state of a database. This is autonatically set when using `db_write()` but you can adjust it manually with this function if you choose.
/// 
/// @param database
/// @param state

function db_set_changed(_database, _state)
{
    _database.__changed = _state;
    if (_state) _database.__timestamp = date_current_datetime();
}
