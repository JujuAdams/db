// Feather disable all

/// Reads a value from a database. If the value cannot be found in the database, `db_default()`
/// will be called using the same keys and that value will be returned instead. If no default value
/// is found using `db_default()` then this function will show an error message.
/// 
/// This function should be used alongside `db_set_default_data()`. If you don't want to use the
/// default data template feature, please instead use `db_read()` which allows you to specify
/// a default value on a case-by-case basis. Please further see `db_write()` for more information
/// regarding database structure.
/// 
/// @param database
/// @param [key]
/// @param ...

function db_read_ext(_database)
{
    if (argument_count < 1) __db_error("Incorrect number of parameters (got ", argument_count, ", was expecting at least 1)");
    
    with(_database)
    {
        var _value = __data;
        if (_value != undefined)
        {
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
                    
                    if (not variable_struct_exists(_value, _key)) break;
                    
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
                    
                    if (_key >= array_length(_value)) break;
                
                    _value = _value[_key];
                }
                else
                {
                    __db_error("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
                }
            
                ++_i;
            }
            
            if (_i >= argument_count)
            {
                return _value;
            }
        }
        
        if (argument_count == 1)
        {
            return db_default(_database);
        }
        else if (argument_count == 2)
        {
            return db_default(_database, argument[1]);
        }
        else if (argument_count == 3)
        {
            return db_default(_database, argument[1], argument[2]);
        }
        else if (argument_count == 4)
        {
            return db_default(_database, argument[1], argument[2], argument[3]);
        }
        else if (argument_count == 5)
        {
            return db_default(_database, argument[1], argument[2], argument[3], argument[4]);
        }
        else if (argument_count == 6)
        {
            return db_default(_database, argument[1], argument[2], argument[3], argument[4], argument[5]);
        }
        else if (argument_count == 7)
        {
            return db_default(_database, argument[1], argument[2], argument[3], argument[4], argument[5], argument[6]);
        }
        else
        {
            static _array = [];
            array_resize(_array, argument_count);
            
            var _i = 0;
            repeat(argument_count)
            {
                _array[@ _i] = argument[_i];
                ++_i;
            }
            
            script_execute_ext(db_default, _array);
            array_resize(_array, 0);
        }
    }
    
    return undefined;
}
