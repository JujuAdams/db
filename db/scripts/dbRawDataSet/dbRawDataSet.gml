/// @param database
/// @param data
/// @param [setChanged=false]

function DbRawDataSet(_database, _data, _setChanged = false)
{
    _database.__data = _data;
    if (_setChanged) _database.__changed = true;
}