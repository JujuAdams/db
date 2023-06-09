/// @param buffer
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]

function dbBufferWrite(_buffer, _database, _pretty = false, _accurateFloats = false)
{
    __dbBufferWriteJSON(_buffer,
                           {
                               data:      _database.__data,
                               metadata:  _database.__metadata,
                               timestamp: _database.__timestamp,
                               version:   __DB_FILE_VERSION,
                           },
                           _pretty, _pretty, _accurateFloats);
}