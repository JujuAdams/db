/// @param database
/// @param value
/// @param key
/// @param ...

function DbWrite(_database, _setValue)
{
    if (argument_count < 3) __DbError("Incorrect number of arguments (got ", argument_count, ", was expecting at least 3)");
    
    with(_database)
    {
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
                __DbError("Keys must be strings (struct access) or numbers (array access)\nKey was ", typeof(argument[1]));
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
                if (!is_struct(_node)) __DbError("Key provided is a string (", _key, ") but current data structure is not a struct");
                
                if (variable_struct_exists(_node, _key))
                {
                    if (_i >= argument_count-1)
                    {
                        //Final key, write to the struct
                        if (_node[$ _key] != _setValue) _changed = true;
                        _node[$ _key] = _setValue;
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
                        //Final key, write to the struct
                        if (_node[$ _key] != _setValue)
                        {
                            _node[$ _key] = _setValue;
                            _changed = true;
                        }
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
                        __DbError("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
                    }
                }
            }
            else if (is_numeric(_key))
            {
                if (!is_array(_node)) __DbError("Key provided is a number (", _key, ") but current data structure is not an array");
                
                if (_key < 0) __DbError("Array index is less than 0 (", _key, ")");
                
                if (_key < array_length(_node))
                {
                    if (_i >= argument_count-1)
                    {
                        //Final key, write to the array
                        if (_node[@ _key] != _setValue)
                        {
                            _node[@ _key] = _setValue;
                            _changed = true;
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
                    else
                    {
                        if (_i >= argument_count-1)
                        {
                            if (_node[_key] != _setValue) _changed = true;
                        }
                    }
                    
                    if (_i >= argument_count-1)
                    {
                        _node[@ _key] = _setValue;
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
                            __DbError("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
                        }
                    }
                }
            }
            else
            {
                __DbError("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
            }
            
            ++_i;
        }
        
        if (is_struct(_setValue) || is_array(_setValue)) _changed = true;
        if (_changed) __changed = true;
    }
}