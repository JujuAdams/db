// Feather disable all

/// Reads the default value for a sequence of keys, as set by `db_set_default_data()`. If default
/// data cannot be found for the given key then this function will show an error message.
/// 
/// @param database
/// @param [key]
/// @param ...

function db_default(_database)
{
    if (argument_count < 1) __db_error("Incorrect number of parameters (got ", argument_count, ", was expecting at least 1)");
    
    with(_database)
    {
        var _value = __defaultData;
        if (_value == undefined)
        {
            __db_error("No default data has been set with `db_set_default_data()`");
        }
        
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
                
                if (variable_struct_exists(_value, _key))
                {
                    _value = _value[$ _key];
                }
                else if (struct_exists_from_hash(_value, variable_get_hash("__template")))
                {
                    _value = struct_get_from_hash(_value, variable_get_hash("__template"));
                }
                else
                {
                    __db_error("Struct has no \"__template\" variable and is missing variable \"", _key, "\"");
                }
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
                
                if (array_length(_value) <= 0)
                {
                    __db_error("Template array is empty");
                }
                
                _value = _value[clamp(_key, 0, array_length(_value)-1)];
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