// Feather disable all

/// Synchronously loads a database that has been saved by `db_debug_save()`. If this function fails
/// to load the file or fails to parse its contents then this function will return `undefined`. Be
/// sure to handle this failure state.
/// 
/// N.B. This function is provided for debug use only and should not be used in production or on
///      consoles. Instead, load the buffer asynchronously and use `db_buffer_read()` to create a
///      database from the loaded binary data.
/// 
/// @param path

function db_debug_load(_path)
{
    var _database = undefined;
    
    try
    {
        var _buffer = buffer_load(_path);
        _database = __db_deserialize(buffer_read(_buffer, buffer_text));
    }
    catch(_error)
    {
        show_debug_message("db: Warning! Failed to parse JSON");
    }
    finally
    {
        buffer_delete(_buffer);
    }
    
    return _database;
}
