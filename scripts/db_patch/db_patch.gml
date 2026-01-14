// Feather disable all

/// Merges a struct/json into a database rather than strictly overwriting the existing value. The
/// patch operation is recursive and you can merge complex trees of data into a database.
/// 
/// When patching arrays, you may want to skip certain indexes. To skip an index, set the value at
/// that index to `pointer_null` in the incoming patch data. For example:
/// 
///   database = db_create([ 0, 1, 2 ]);
///   db_merge(database, [ "a", pointer_null, "c" ]);
///   db_get_raw_data(database) --> ["a", 1, "c"];
/// 
/// @param database
/// @param structOrArray
/// @param [key]
/// @param ...

function db_patch(_database, _patch_value)
{
    if (argument_count < 2) __db_error("Incorrect number of parameters (got ", argument_count, ", was expecting 3 or more)");
    
    //Convert an incoming database into raw data for merging
    if (is_db(_patch_value))
    {
        _patch_value = db_get_raw_data(_patch_value);
    }
    
    //Use the simplier `db_write()` function if we're not patching complex data
    if ((not is_struct(_patch_value)) && (not is_array(_patch_value)))
    {
        var _argument_array = array_create(argument_count, undefined);
        var _i = 0;
        repeat(array_length(_argument_array))
        {
            _argument_array[_i] = argument[_i];
            ++_i;
        }
        
        return script_execute_ext(db_write, _argument_array);
    }
    
    with(_database)
    {
        var _changed = false;
        
        var _node = __data;
        if (_node == undefined)
        {
            if (argument_count == 2)
            {
                if (is_struct(_patch_value))
                {
                    _node = {};
                }
                else if (is_numeric(_patch_value))
                {
                    _node = [];
                }
                else
                {
                    __db_error("Patch values must be structs or arrays\nPatch value was ", typeof(_patch_value));
                }
                
                _changed = true;
            }
            else
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
                
                _changed = true;
            }
            
            __data = _node;
        }
        
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
                    _node = _node[$ _key];
                }
                else
                {
                    //Adding a new key
                    
                    if (_i >= argument_count-1)
                    {
                        if (is_struct(_patch_value))
                        {
                            _changed = true;
                            _node = {};
                            _oldNode[$ _key] = _node;
                        }
                        else if (is_array(_patch_value))
                        {
                            _changed = true;
                            _node = [];
                            _oldNode[$ _key] = _node;
                        }
                    }
                    else
                    {
                        if (is_string(_key))
                        {
                            _changed = true;
                            _node = {};
                            _oldNode[$ _key] = _node;
                        }
                        else if (is_numeric(_key))
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
            }
            else if (is_numeric(_key))
            {
                if (not is_array(_node)) __db_error("Key provided is a number (", _key, ") but current data structure is not an array");
                
                if (_key < 0) __db_error("Array index is less than 0 (", _key, ")");
                
                if (_key < array_length(_node))
                {
                    _node = _node[_key];
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
                        if (is_struct(_patch_value))
                        {
                            _changed = true;
                            _node = {};
                            _oldNode[@ _key] = _node;
                        }
                        else if (is_array(_patch_value))
                        {
                            _changed = true;
                            _node = [];
                            _oldNode[@ _key] = _node;
                        }
                    }
                    else
                    {
                        if (is_string(_key))
                        {
                            _changed = true;
                            _node = {};
                            _oldNode[@ _key] = _node;
                        }
                        else if (is_numeric(_key))
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
        
        //Actually perform the patch
        if (is_struct(_node) && is_struct(_patch_value))
        {
            var _names_array = variable_struct_get_names(_patch_value);
            var _i = 0;
            repeat(array_length(_names_array))
            {
                var _name = _names_array[_i];
                _node[$ _name] = _patch_value[$ _name];
                ++_i;
            }
        }
        else if (is_array(_node) && is_array(_patch_value))
        {
            array_resize(_node, max(array_length(_node), array_length(_patch_value)));
            
            var _i = array_length(_patch_value)-1;
            repeat(array_length(_patch_value))
            {
                var _value = _patch_value[_i];
                if ((not is_ptr(_value)) && (_value != pointer_null))
                {
                    _node[_i] = _value;
                }
                
                --_i;
            }
        }
        else
        {
            __db_error("Datatype mismatch between discovered node and patch data (discovered \"", typeof(_node), "\", patch data was \"", typeof(_patch_value), "\")");
        }
        
        if (_changed) __changed = true;
    }
}
