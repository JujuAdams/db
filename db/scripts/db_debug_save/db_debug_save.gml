// Feather disable all

/// Synchronously saves a database to the device's storage. You can load it later using
/// `db_debug_load()`. This function does not set the timestamp for the database and you should
/// call `db_set_timestamp()` before saving.
/// 
/// N.B. This function is provided for debug use only and should not be used in production or on
///      consoles. Instead, please use `db_buffer_write()` or `db_buffer_create()` and save the
///      buffer asynchronously.
/// 
/// Setting the `pretty` optional parameter to `true` will save the file in a more easily readable
/// format. Setting `accurateFloats` to `true` will use a custom JSON exporter that writes decimal
/// numbers at a higher accuracy. This carries a performance penalty but might sometimes be
/// helpful.
/// 
/// @param database
/// @param path
/// @param [pretty=false]
/// @param [accurateFloats=false]

function db_debug_save(_database, _path, _pretty = false, _accurate_floats = false)
{
    var _buffer = db_buffer_create(_database, _pretty, _accurate_floats);
    buffer_save(_buffer, _path);
    buffer_delete(_buffer);
}
