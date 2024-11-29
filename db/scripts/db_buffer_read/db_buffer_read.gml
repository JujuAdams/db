// Feather disable all

/// Reads a database from a buffer. This function creates a new database and returns it.
/// 
/// @param buffer

function db_buffer_read(_buffer)
{
    return __db_deserialize(buffer_read(_buffer, buffer_string));
}
