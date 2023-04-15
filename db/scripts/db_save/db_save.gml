/// @param database
/// @param filename
/// @param [pretty=false]

function db_save(_database, _filename, _pretty = false)
{
    var _string = __db_serialize(_database, _pretty);
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    buffer_save(_buffer, _filename);
    buffer_delete(_buffer);
}