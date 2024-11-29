// Feather disable all

/// Synchronously saves a database. You can load it later using `db_load()`.
/// 
/// N.B. This function should not be used on console (Switch, PS5 etc.) as it saves a file synchronously.
///      Instead, use `db_buffer_write()` and save the buffer asynchronously using native GameMaker functions.
/// 
/// @param database
/// @param filename
/// @param [pretty=false]
/// @param [accurateFloats=false]

function db_save(_database, _filename, _pretty = false, _accurate_floats = false)
{
    var _buffer = buffer_create(1024, buffer_grow, 1);
    db_buffer_write(_buffer, _database, _pretty, _accurate_floats);
    buffer_save_ext(_buffer, _filename, 0, buffer_tell(_buffer));
    buffer_delete(_buffer);
}
