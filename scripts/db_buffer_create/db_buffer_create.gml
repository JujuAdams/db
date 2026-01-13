// Feather disable all

/// Writes a database to a newly created buffer. This buffer can be saved to local storage or
/// passed over a network connection etc.  The buffer can be turned back into a database by
/// calling `db_buffer_read()`.
/// 
/// N.B. This function does not set the timestamp for the database and you should call
//       `db_set_timestamp()` before saving.
/// 
/// Setting the `pretty` optional parameter to `true` will create the buffer with data in a more
/// easily readable format. Setting `accurateFloats` to `true` will use a custom JSON exporter that
/// writes decimal numbers at a higher accuracy. This carries a performance penalty but might
/// sometimes be helpful.
/// 
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]

function db_buffer_create(_database, _pretty = false, _accurate_floats = false)
{
    var _buffer = buffer_create(1, buffer_grow, 1);
    db_buffer_write(_buffer, _database, _pretty, _accurate_floats);
    buffer_resize(_buffer, buffer_tell(_buffer));
    
    return _buffer;
}
