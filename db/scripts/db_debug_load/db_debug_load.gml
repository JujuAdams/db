// Feather disable all

/// Synchronously loads a database that has been saved by `db_debug_save()`.
/// 
/// N.B. This function is provided for debug use only and should not be used in production.
///      Instead, load the buffer asynchronously and use `db_buffer_read()`.
/// 
/// N.B. This function will not work properly on console (Switch, PlayStation, Xbox).

function db_debug_load(_filename)
{
    if (!file_exists(_filename)) __db_error("Could not find \"", _filename, "\"");
    
    var _buffer   = undefined;
    var _database = undefined;
    
    try
    {
        _buffer = buffer_load(_filename);
        _database = __db_deserialize(buffer_read(_buffer, buffer_text));
        buffer_delete(_buffer);
    }
    catch(_error)
    {
        show_debug_message("db: Warning! Failed to parse JSON");
    }
    
    if ((_buffer != undefined) && (_buffer > 0)) buffer_delete(_buffer);
    
    return _database;
}
