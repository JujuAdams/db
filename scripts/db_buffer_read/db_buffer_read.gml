// Feather disable all

/// Reads a buffer and creates a new database from its contents. If the buffer contains invalid
/// data or has been corrupted in some way then this function will return `undefined`.
/// 
/// If you set the `consumeBuffer` optional parameter to `true` then the input buffer will be
/// deleted automatically.
/// 
/// @param buffer
/// @param [consumeBuffer=false]

function db_buffer_read(_buffer, _consumeBuffer = false)
{
    var _database = undefined;
    
    try
    {
        _database = __db_deserialize(buffer_read(_buffer, buffer_string));
    }
    catch(_error)
    {
        __db_trace(_error);
        __db_trace("Warning! Failed to parse buffer");
    }
    
    if (_consumeBuffer && buffer_exists(_buffer))
    {
        buffer_delete(_buffer);
    }
    
    return _database;
}
