/// @param database
/// @param key
/// @param ...

function DbExists(_database)
{
    with(_database)
    {
        var _node = __data;
        if (_node == undefined) return false;
        
        var _i = 1;
        repeat(argument_count-1)
        {
            var _key = argument[_i];
            
            if (is_string(_key))
            {
                if (!is_struct(_node))
                {
                    __DbError("Key provided is a string (", _key, ") but current data structure is not a struct");
                }
                
                if (!variable_struct_exists(_node, _key)) return false;
                
                _node = _node[$ _key];
            }
            else if (is_numeric(_key))
            {
                if (!is_array(_node))
                {
                    __DbError("Key provided is a number (", _key, ") but current data structure is not an array");
                }
                
                if (_key < 0)
                {
                    __DbError("Array index is less than 0 (", _key, ")");
                }
                
                if (_key >= array_length(_node)) return false;
                
                _node = _node[_key];
            }
            else
            {
                __DbError("Key must be a string (struct access) or a number (array access)\nKey was ", typeof(_key));
            }
        
            ++_i;
        }
        
        return true;
    }
}