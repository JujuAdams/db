// Feather disable all

/// Writes a database to a newly created buffer.
/// 
/// N.B. This function does *not* set the timestamp for the database and you should call
//       `db_set_timestamp()` before saving.
/// 
/// @param database
/// @param [pretty=false]
/// @param [accurateFloats=false]
/// @param [legacyMode=false]

function db_buffer_create(_database, _pretty = false, _accurate_floats = false, _legacy_mode = false)
{
    var _buffer = buffer_create(1, buffer_grow, 1);
    
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
    
    buffer_resize(_buffer, buffer_tell(_buffer));
    
    return _buffer;
}
