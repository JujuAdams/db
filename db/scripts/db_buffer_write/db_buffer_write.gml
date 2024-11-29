// Feather disable all

/// Writes a database to a buffer. This buffer can be read back with `db_buffer_read()`.
/// 
/// N.B. This function does *not* set the timestamp for the database and you should call `db_set_timestamp()` before saving.
/// 
/// @param buffer
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]

function db_buffer_write(_buffer, _database, _pretty = false, _accurate_floats = false)
{
    __db_buffer_write_json(_buffer,
                           {
                               data:      _database.__data,
                               metadata:  _database.__metadata,
                               timestamp: _database.__timestamp,
                               version:   1,
                           },
                           _pretty, _pretty, _accurate_floats);
}
