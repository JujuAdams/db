// Feather disable all

/// Writes a database to a pre-existing buffer. This buffer can be saved to local storage or
/// passed over a network connection etc.  The buffer can be turned back into a database by
/// calling `db_buffer_read()`.
/// 
/// N.B. This function does not set the timestamp for the database and you should call
///      `db_set_timestamp()` before saving.
/// 
/// Setting the `pretty` optional parameter to `true` will write to the buffer in a more easily
/// readable format. Setting `accurateFloats` to `true` will use a custom JSON exporter that writes
/// decimal numbers at a higher accuracy. This carries a performance penalty but might sometimes be
/// helpful.
/// 
/// @param buffer
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]

function db_buffer_write(_buffer, _database, _pretty = false, _accurate_floats = false)
{
    var _payload = {
        data:      _database.__data,
        metadata:  _database.__metadata,
        timestamp: _database.__timestamp,
        version:   DB_SAVE_VERSION,
    };
    
    if (_accurate_floats)
    {
        __db_buffer_write_json(_buffer, _payload, _pretty, _pretty, true);
    }
    else
    {
        buffer_write(_buffer, buffer_text, json_stringify(_payload, _pretty));
    }
}
