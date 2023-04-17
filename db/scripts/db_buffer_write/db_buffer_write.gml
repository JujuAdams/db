/// @param buffer
/// @param database
/// @param [pretty=false]

function db_buffer_write(_buffer, _database, _pretty = false)
{
    __db_buffer_write_json(_buffer,
                        {
                            database:  _database.__data,
                            metadata:  _database.__metadata,
                            timestamp: _database.__timestamp,
                            version:   1,
                        },
                        _pretty, _pretty, true);
}