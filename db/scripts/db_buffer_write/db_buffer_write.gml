// Feather disable all

/// Writes a database to a buffer. This buffer can be read back with `db_buffer_read()`.
/// 
/// N.B. This function does *not* set the timestamp for the database and you should call `db_set_timestamp()` before saving.
/// 
/// @param buffer
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]
/// @param [legacyMode=false]

function db_buffer_write(_buffer, _database, _pretty = false, _accurate_floats = false, _legacy_mode = false)
{
    var _payload = {
        data:      _database.__data,
        metadata:  _database.__metadata,
        timestamp: _database.__timestamp,
        version:   DB_SAVE_VERSION,
    };
    
    if (_legacy_mode)
    {
        __db_buffer_write_json(_buffer, _payload, _pretty, _pretty, _accurate_floats);
    }
    else
    {
        if (_accurate_floats)
        {
            __db_error("Accurate float mode is only supported in legacy mode at this time");
        }
        
        buffer_write(_buffer, buffer_text, json_stringify(_payload, _pretty));
    }
}
