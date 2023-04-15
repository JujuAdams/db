/// @param buffer
/// @param database
/// @param [pretty=false]

function db_buffer_write(_buffer, _database, _pretty = false)
{
    buffer_write(_buffer, buffer_text, __db_serialize(_database, _pretty));
}