// Feather disable all

/// Reads a value from a database. If the value cannot be found then `undefined` will be returned.
/// This means that this function, unlike `db_read_then_default()`, will ignore values set by
/// `db_set_default_data()`. Please see `db_write()` for more information regarding database
/// structure.
/// 
/// @param database
/// @param [key]
/// @param ...

function db_read(_database)
{
    if (argument_count < 1) __db_error("Incorrect number of parameters (got ", argument_count, ", was expecting at least 1)");
    
    with(_database)
    {
        var _value = __data;
        if (_value == undefined) return undefined;
        
        var _i = 1;
        repeat(argument_count-1)
        {
            var _key = argument[_i];
            
            if (is_string(_key))
            {
                if (not is_struct(_value))
                {
                    __db_error("Key provided is a string (", _key, ") but current data structure is not a struct");
                }
                
                if (not variable_struct_exists(_value, _key)) return undefined;
                
                _value = _value[$ _key];
            }
            else if (is_numeric(_key))
            {
                if (not is_array(_value))
                {
                    __db_error("Key provided is a number (", _key, ") but current data structure is not an array");
                }
                
                if (_key < 0)
                {
                    __db_error("Array index is less than 0 (", _key, ")");
                }
                
                if (_key >= array_length(_value)) return undefined;
                
                _value = _value[_key];
            }
            else
            {
                __db_error("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
            }
            
            ++_i;
        }
        
        return _value;
    }
}
