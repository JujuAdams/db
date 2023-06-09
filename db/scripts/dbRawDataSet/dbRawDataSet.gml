/// @param database
/// @param data
/// @param [setChanged=false]

function dbRawDataSet(_database, _data, _set_changed = false)
{
    _database.__data = _data;
    if (_set_changed) _database.__changed = true;
}