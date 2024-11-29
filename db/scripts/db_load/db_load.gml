// Feather disable all

/// Synchronously loads a database that has been saved by `db_save()`.
/// 
/// N.B. This function should not be used on console (Switch, PS5 etc.) as it loads a file synchronously.
///      Instead, use `db_buffer_write()` and load the buffer asynchronously using native GameMaker functions.

function db_load(_filename)
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
        
    }
    
    if ((_buffer != undefined) && (_buffer > 0)) buffer_delete(_buffer);
    
    return _database;
}
