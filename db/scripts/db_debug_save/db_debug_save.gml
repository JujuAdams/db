// Feather disable all

/// Synchronously saves a database to the device's storage. You can load it later using
/// `db_debug_load()`. This function does not set the timestamp for the database and you should
/// call `db_set_timestamp()` before saving.
/// 
/// N.B. This function is provided for debug use only and should not be used in production or on
///      consoles. Instead, please use `db_buffer_write()` or `db_buffer_create()` and save the
///      buffer asynchronously.
/// 
/// @param database
/// @param path
/// @param [pretty=false]
/// @param [accurateFloats=false]
/// @param [legacyMode=false]

function db_debug_save(_database, _path, _pretty = false, _accurate_floats = false, _legacy_mode = false)
{
    var _payload = {
        data:      _database.__data,
        metadata:  _database.__metadata,
        timestamp: _database.__timestamp,
        version:   DB_SAVE_VERSION,
    };
    
    if (_legacy_mode)
    {
        var _buffer = buffer_create(1024, buffer_grow, 1);
        db_buffer_write(_buffer, _database, _pretty, _accurate_floats, true);
    }
    else
    {
        if (_accurate_floats)
        {
            __db_error("Accurate float mode is only supported in legacy mode at this time");
        }
        
        var _string = json_stringify(_payload, _pretty);
        var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
        buffer_write(_buffer, buffer_text, _string);
    }
    
    buffer_save_ext(_buffer, _path, 0, buffer_tell(_buffer));
    buffer_delete(_buffer);
}
