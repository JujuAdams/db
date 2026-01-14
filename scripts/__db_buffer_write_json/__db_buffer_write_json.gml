// Feather disable all
function __db_buffer_write_json(_buffer, _value, _pretty = false, _alphabetise = false, _accurateFloats = false)
{
    return __db_to_json_buffer_value(_buffer, _value, _pretty, _alphabetise, _accurateFloats, "");
}

function __db_to_json_buffer_value(_buffer, _value, _pretty, _alphabetise, _accurateFloats, _indent)
{
    if (is_real(_value) || is_int32(_value) || is_int64(_value))
    {
        buffer_write(_buffer, buffer_text, __db_number_to_string(_value, _accurateFloats));
    }
    else if (is_string(_value))
    {
        //Sanitise strings
        _value = string_replace_all(_value, "\\", "\\\\");
        _value = string_replace_all(_value, "\n", "\\n");
        _value = string_replace_all(_value, "\r", "\\r");
        _value = string_replace_all(_value, "\t", "\\t");
        _value = string_replace_all(_value, "\"", "\\\"");
        
        buffer_write(_buffer, buffer_u8,   0x22); // Double quote
        buffer_write(_buffer, buffer_text, _value);
        buffer_write(_buffer, buffer_u8,   0x22); // Double quote
    }
    else if (is_array(_value))
    {
        var _array = _value;

        var _count = array_length(_array);
        if (_count <= 0)
        {
            buffer_write(_buffer, buffer_u16, 0x5D5B); //Open then close square bracket
        }
        else
        {
            if (_pretty)
            {
                buffer_write(_buffer, buffer_u16, 0x0A5B); //Open square bracket + newline
                
                var _preIndent = _indent;
                _indent += chr(0x09); //Tab
                
                var _i = 0;
                repeat(_count)
                {
                    buffer_write(_buffer, buffer_text, _indent);
                    __db_to_json_buffer_value(_buffer, _array[_i], _pretty, _alphabetise, _accurateFloats, _indent);
                    buffer_write(_buffer, buffer_u16, 0x0A2C); //Comma + newline
                    ++_i;
                }
                
                _indent = _preIndent;
                
                buffer_seek(_buffer, buffer_seek_relative, -2);
                buffer_write(_buffer, buffer_u8, 0x0A); //Newline
                buffer_write(_buffer, buffer_text, _indent);
                buffer_write(_buffer, buffer_u8, 0x5D); //Close square bracket
            }
            else
            {
                buffer_write(_buffer, buffer_u8, 0x5B); //Open square bracket
                
                var _i = 0;
                repeat(_count)
                {
                    __db_to_json_buffer_value(_buffer, _array[_i], _pretty, _alphabetise, _accurateFloats, _indent);
                    buffer_write(_buffer, buffer_u8, 0x2C); //Comma
                    ++_i;
                }
                
                if (_count > 0) buffer_seek(_buffer, buffer_seek_relative, -1);
                buffer_write(_buffer, buffer_u8, 0x5D); //Close square bracket
            }
        }
    }
    else if (is_method(_value)) //Implicitly also a struct so we have to check this first
    {
        buffer_write(_buffer, buffer_u8,   0x22); // Double quote
        buffer_write(_buffer, buffer_text, string(_value));
        buffer_write(_buffer, buffer_u8,   0x22); // Double quote
    }
    else if (is_struct(_value))
    {
        var _struct = _value;
        
        var _names = variable_struct_get_names(_struct);
        if (_alphabetise) array_sort(_names, true);
        
        var _count = array_length(_names);
        if (_count <= 0)
        {
            buffer_write(_buffer, buffer_u16, 0x7D7B); //Open then close curly bracket
        }
        else
        {
            if (_pretty)
            {
                buffer_write(_buffer, buffer_u16, 0x0A7B); //Open curly bracket + newline
                
                var _preIndent = _indent;
                _indent += chr(0x09); //Tab
                
                var _i = 0;
                repeat(_count)
                {
                    var _name = _names[_i];
                    if (not is_string(_name)) show_error("__db_buffer_write_json:\nKeys must be strings\n ", true);
                    
                    buffer_write(_buffer, buffer_text, _indent);
                    buffer_write(_buffer, buffer_u8,   0x22); // Double quote
                    buffer_write(_buffer, buffer_text, string(_name));
                    buffer_write(_buffer, buffer_u32,  0x203A2022); // <" : >
                    
                    __db_to_json_buffer_value(_buffer, _struct[$ _name], _pretty, _alphabetise, _accurateFloats, _indent);
                    
                    buffer_write(_buffer, buffer_u16, 0x0A2C); //Comma + newline
                    
                    ++_i;
                }
                
                _indent = _preIndent;
                
                buffer_seek(_buffer, buffer_seek_relative, -2);
                buffer_write(_buffer, buffer_u8, 0x0A); //Newline
                buffer_write(_buffer, buffer_text, _indent);
                buffer_write(_buffer, buffer_u8, 0x7D); //Close curly bracket
            }
            else
            {
                buffer_write(_buffer, buffer_u8, 0x7B); //Open curly bracket
                
                var _i = 0;
                repeat(_count)
                {
                    var _name = _names[_i];
                    if (not is_string(_name)) show_error("__db_buffer_write_json:\nKeys must be strings\n ", true);
                    
                    buffer_write(_buffer, buffer_u8,   0x22); // Double quote
                    buffer_write(_buffer, buffer_text, string(_name));
                    buffer_write(_buffer, buffer_u16,  0x3A22); // Double quote then colon
                    
                    __db_to_json_buffer_value(_buffer, _struct[$ _name], _pretty, _alphabetise, _accurateFloats, _indent);
                    
                    buffer_write(_buffer, buffer_u8, 0x2C); //Comma
                    
                    ++_i;
                }
                
                buffer_seek(_buffer, buffer_seek_relative, -1);
                buffer_write(_buffer, buffer_u8, 0x7D); //Close curly bracket
            }
        }
    }
    else if (is_undefined(_value))
    {
        buffer_write(_buffer, buffer_text, "null");
    }
    else if (is_bool(_value))
    {
        buffer_write(_buffer, buffer_text, _value? "true" : "false");
    }
    else if (is_ptr(_value))
    {
        //Not 100% sure if the quote delimiting is necessary but better safe than sorry
        buffer_write(_buffer, buffer_u8,   0x22);
        buffer_write(_buffer, buffer_text, string(_value));
        buffer_write(_buffer, buffer_u8,   0x22);
    }
    else if (is_handle(_value))
    {
        buffer_write(_buffer, buffer_u8,   0x22);
        buffer_write(_buffer, buffer_text, string(_value));
        buffer_write(_buffer, buffer_u8,   0x22);
    }
    else
    {
        //Catch future unsupported types ... hopefully
        if (is_numeric(_value))
        {
            buffer_write(_buffer, buffer_text, string(real(_value)));
        }
        else
        {
            buffer_write(_buffer, buffer_text, string(_value));
        }
    }
    
    return _buffer;
}
