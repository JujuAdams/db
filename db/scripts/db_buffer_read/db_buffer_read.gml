// Feather disable all

/// Reads a buffer and creates a new database from its contents. If the buffer contains invalid
/// data or has been corrupted in some way then this function will return `undefined`.
/// 
/// @param buffer

function db_buffer_read(_buffer)
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
    
    return _database;
}
