/// @param database
/// @param default
/// @param key
/// @param ...

function DbRead(_database, _default)
{
    if (argument_count < 3) __DbError("Incorrect number of arguments (got ", argument_count, ", was expecting at least 3)");
    
    with(_database)
    {
        var _value = __data;
        if (_value == undefined) return _default;
        
        var _i = 2;
        repeat(argument_count-2)
        {
            var _key = argument[_i];
            
            if (is_string(_key))
            {
                if (!is_struct(_value))
                {
                    __DbError("Key provided is a string (", _key, ") but current data structure is not a struct");
                }
                
                if (!variable_struct_exists(_value, _key)) return _default;
                
                _value = _value[$ _key];
            }
            else if (is_numeric(_key))
            {
                if (!is_array(_value))
                {
                    __DbError("Key provided is a number (", _key, ") but current data structure is not an array");
                }
                
                if (_key < 0)
                {
                    __DbError("Array index is less than 0 (", _key, ")");
                }
                
                if (_key >= array_length(_value)) return _default;
                
                _value = _value[_key];
            }
            else
            {
                __DbError("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
            }
            
            ++_i;
        }
        
        return _value;
    }
}