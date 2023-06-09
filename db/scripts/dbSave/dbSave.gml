/// @param database
/// @param filename
/// @param [pretty=false]
/// @param [accurateFloats=false]

function DbSave(_database, _filename, _pretty = false, _accurateFloats = false)
{
    var _buffer = buffer_create(1024, buffer_grow, 1);
    DbBufferWrite(_buffer, _database, _pretty, _accurateFloats);
    buffer_save_ext(_buffer, _filename, 0, buffer_tell(_buffer));
    buffer_delete(_buffer);
}