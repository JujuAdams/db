/// @param buffer
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]

function DbBufferWrite(_buffer, _database, _pretty = false, _accurateFloats = false)
{
    __DbBufferWriteJSON(_buffer,
                           {
                               data:      _database.__data,
                               metadata:  _database.__metadata,
                               timestamp: _database.__timestamp,
                               version:   __DB_FILE_VERSION,
                           },
                           _pretty, _pretty, _accurateFloats);
}