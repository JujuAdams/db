// Feather disable all

/// It is a common operation to increment a value in savedata, for example to track progress
/// towards a quest reward or achievement. This function allows you to increment (or decrement) a
/// numerical value stored inside a database. This function only works on numerical values although
/// a value of `undefined` will be treated as `0`.
/// 
/// @param database
/// @param addValue
/// @param [key]
/// @param ...

function db_add(_database, _add_value)
{
    if (_add_value == undefined)
    {
        //Common "do nothing" value, no need to throw an error for this
        return;
    }
    
    if (not is_numeric(_add_value))
    {
        __db_error("`db_add()` only accepts a number for the `addValue` parameter");
    }
    
    if (_add_value == 0)
    {
        //No change
        return;
    }
    
    if (argument_count < 2)
    {
        __db_error("Incorrect number of parameters (got ", argument_count, ", was expecting 2 or more)");
    }
    
    with(_database)
    {
        if (argument_count == 2)
        {
            if (__data == undefined)
            {
                __data = _add_value;
                __changed = true;
            }
            else if (is_numeric(__data))
            {
                __data += _add_value;
                __changed = true;
            }
            else
            {
                __db_error($"Cannot add to a non-numeric value (typeof={typeof(_existingValue)}, value={_existingValue})");
            }
            
            return;
        }
        
        var _node = __data;
        if (_node == undefined)
        {
            if (is_string(argument[2]))
            {
                _node = {};
            }
            else if (is_numeric(argument[2]))
            {
                _node = [];
            }
            else
            {
                __db_error("Keys must be strings (struct access) or numbers (array access)\nKey was ", typeof(argument[1]));
            }
            
            __data = _node;
        }
        
        var _changed = false;
        
        var _i = 2;
        repeat(argument_count-2)
        {
            var _oldNode = _node;
            var _key = argument[_i];
            
            if (is_string(_key))
            {
                if (not is_struct(_node)) __db_error("Key provided is a string (", _key, ") but current data structure is not a struct");
                
                if (variable_struct_exists(_node, _key))
                {
                    if (_i >= argument_count-1)
                    {
                        //Final key, add the value
                        
                        var _existingValue = _node[$ _key] ?? 0;
                        if (is_numeric(_existingValue))
                        {
                            _node[$ _key] = _existingValue + _add_value;
                        }
                        else
                        {
                            __db_error($"Cannot add to a non-numeric value (typeof={typeof(_existingValue)}, value={_existingValue})");
                        }
                    }
                    else
                    {
                        _node = _node[$ _key];
                    }
                }
                else
                {
                    //Adding a new key
                    
                    if (_i >= argument_count-1)
                    {
                        //Final key, write the value
                        _node[$ _key] = _add_value;
                    }
                    else if (is_string(argument[_i+1]))
                    {
                        _changed = true;
                        _node = {};
                        _oldNode[$ _key] = _node;
                    }
                    else if (is_numeric(argument[_i+1]))
                    {
                        _changed = true;
                        _node = [];
                        _oldNode[$ _key] = _node;
                    }
                    else
                    {
                        __db_error("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
                    }
                }
            }
            else if (is_numeric(_key))
            {
                if (not is_array(_node)) __db_error("Key provided is a number (", _key, ") but current data structure is not an array");
                
                if (_key < 0) __db_error("Array index is less than 0 (", _key, ")");
                
                if (_key < array_length(_node))
                {
                    if (_i >= argument_count-1)
                    {
                        //Final key, add the value
                        
                        var _existingValue = _node[$ _key] ?? 0;
                        if (is_numeric(_existingValue))
                        {
                            _node[$ _key] = _existingValue + _add_value;
                        }
                        else
                        {
                            __db_error($"Cannot add to a non-numeric value (typeof={typeof(_existingValue)}, value={_existingValue})");
                        }
                    }
                    else
                    {
                        _node = _node[_key];
                    }
                }
                else
                {
                    //Adding a new key
                    
                    var _oldSize = array_length(_node);
                    if (_oldSize < _key+1)
                    {
                        _changed = true;
                        array_resize(_node, _key+1);
                        
                        var _j = _oldSize;
                        repeat(_key - _j)
                        {
                            _node[@ _j] = undefined;
                            ++_j;
                        }
                    }
                    
                    if (_i >= argument_count-1)
                    {
                        _node[@ _key] = _add_value;
                    }
                    else
                    {
                        if (is_string(argument[_i+1]))
                        {
                            _changed = true;
                            _node = {};
                            _oldNode[@ _key] = _node;
                        }
                        else if (is_numeric(argument[_i+1]))
                        {
                            _changed = true;
                            _node = [];
                            _oldNode[@ _key] = _node;
                        }
                        else
                        {
                            __db_error("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
                        }
                    }
                }
            }
            else
            {
                __db_error("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
            }
            
            ++_i;
        }
        
        __changed = true;
    }
}
