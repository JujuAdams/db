/// @param value
/// @param [ascii=false]

function __DbJSONVisualization(_value, _ascii = false)
{
    static _buffer = buffer_create(1024, buffer_grow, 1);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    if (_ascii)
    {
        __DbJSONVisualizationASCIIInner(_buffer, " ", _value);
    }
    else
    {
        __DbJSONVisualizationInner(_buffer, " ", _value);
    }
    
    buffer_write(_buffer, buffer_u8, 0x00);
    return buffer_peek(_buffer, 0, buffer_string);
}

function __DbJSONVisualizationInner(_buffer, _prefix, _value)
{
    if (is_struct(_value))
    {
        if (variable_struct_names_count(_value) == 0)
        {
            buffer_write(_buffer, buffer_text, "{}");
        }
        else
        {
            var _struct = _value;
            
            buffer_write(_buffer, buffer_text, "{}");
            buffer_write(_buffer, buffer_u8, 0x0a); // newline
            
            var _oldPrefix = _prefix;
            var _nameArray = variable_struct_get_names(_struct);
            var _i = 0;
            repeat(array_length(_nameArray)-1)
            {
                var _name = _nameArray[_i];
                _prefix = _oldPrefix + "|    ";
                repeat(string_length(_name)) _prefix += " ";
                
                buffer_write(_buffer, buffer_text, _oldPrefix);
                buffer_write(_buffer, buffer_text, "├─ ");
                buffer_write(_buffer, buffer_text, _name);
                buffer_write(_buffer, buffer_text, ":");
                __DbJSONVisualizationInner(_buffer, _prefix, _struct[$ _name]);
                buffer_write(_buffer, buffer_u8, 0x0a); // newline
                
                ++_i;
            }
            
            var _name = _nameArray[_i];
            buffer_write(_buffer, buffer_text, _oldPrefix);
            buffer_write(_buffer, buffer_text, "└─ ");
            buffer_write(_buffer, buffer_text, _name);
            buffer_write(_buffer, buffer_text, ":");
            
            _prefix = _oldPrefix + "     ";
            repeat(string_length(_name)) _prefix += " ";
            __DbJSONVisualizationInner(_buffer, _prefix, _struct[$ _name]);
        }
    }
    else if (is_array(_value))
    {
        if (array_length(_value) <= 0)
        {
            buffer_write(_buffer, buffer_text, "[]");
        }
        else
        {
            var _array = _value;
            
            buffer_write(_buffer, buffer_text, "[]\n");
            
            var _oldPrefix = _prefix;
            _prefix += "│  ";
            
            var _i = 0;
            repeat(array_length(_array)-1)
            {
                buffer_write(_buffer, buffer_text, _oldPrefix);
                buffer_write(_buffer, buffer_text, "├─");
                __DbJSONVisualizationInner(_buffer, _prefix, _array[_i]);
                buffer_write(_buffer, buffer_u8, 0x0a); // newline
                ++_i;
            }
            
            _prefix = _oldPrefix + "   ";
            buffer_write(_buffer, buffer_text, _oldPrefix);
            buffer_write(_buffer, buffer_text, "└─");
            __DbJSONVisualizationInner(_buffer, _prefix, _array[_i]);
        }
    }
    else if (is_string(_value))
    {
        if (_value == "")
        {
            buffer_write(_buffer, buffer_text, " \"\"");
        }
        else
        {
            buffer_write(_buffer, buffer_text, " \"");
            buffer_write(_buffer, buffer_text, _value);
            buffer_write(_buffer, buffer_text, "\"");
        }
    }
    else
    {
        buffer_write(_buffer, buffer_text, " "); // space
        buffer_write(_buffer, buffer_text, string(_value));
    }
}

function __DbJSONVisualizationASCIIInner(_buffer, _prefix, _value)
{
    if (is_struct(_value))
    {
        if (variable_struct_names_count(_value) == 0)
        {
            buffer_write(_buffer, buffer_text, "{}"); // {}
        }
        else
        {
            var _struct = _value;
            
            buffer_write(_buffer, buffer_text, "{}\n");
            
            var _oldPrefix = _prefix;
            var _nameArray = variable_struct_get_names(_struct);
            var _i = 0;
            repeat(array_length(_nameArray)-1)
            {
                var _name = _nameArray[_i];
                _prefix = _oldPrefix + "|    ";
                repeat(string_length(_name)) _prefix += " ";
                
                buffer_write(_buffer, buffer_text, _oldPrefix);
                buffer_write(_buffer, buffer_text, "|- ");
                buffer_write(_buffer, buffer_text, _name);
                buffer_write(_buffer, buffer_text, ":");
                __DbJSONVisualizationASCIIInner(_buffer, _prefix, _struct[$ _name]);
                buffer_write(_buffer, buffer_text, "\n");
                
                ++_i;
            }
            
            var _name = _nameArray[_i];
            buffer_write(_buffer, buffer_text, _oldPrefix);
            buffer_write(_buffer, buffer_text, "\\- ");
            buffer_write(_buffer, buffer_text, _name);
            buffer_write(_buffer, buffer_text, ":");
            
            _prefix = _oldPrefix + "     ";
            repeat(string_length(_name)) _prefix += " ";
            __DbJSONVisualizationASCIIInner(_buffer, _prefix, _struct[$ _name]);
        }
    }
    else if (is_array(_value))
    {
        if (array_length(_value) <= 0)
        {
            buffer_write(_buffer, buffer_text, "[]");
        }
        else
        {
            buffer_write(_buffer, buffer_text, "[]\n");
            
            var _oldPrefix = _prefix;
            _prefix += "|  ";
            
            var _array = _value;
            var _i = 0;
            repeat(array_length(_array)-1)
            {
                buffer_write(_buffer, buffer_text, _oldPrefix);
                buffer_write(_buffer, buffer_text, "|-");
                __DbJSONVisualizationASCIIInner(_buffer, _prefix, _array[_i]);
                buffer_write(_buffer, buffer_text, "\n");
                ++_i;
            }
            
            buffer_write(_buffer, buffer_text, _oldPrefix);
            _prefix = _oldPrefix + "   ";
            
            buffer_write(_buffer, buffer_text, "\\-");
            __DbJSONVisualizationASCIIInner(_buffer, _prefix, _array[_i]);
        }
    }
    else if (is_string(_value))
    {
        if (_value == "")
        {
            buffer_write(_buffer, buffer_text, " \"\"");
        }
        else
        {
            buffer_write(_buffer, buffer_text, " \"");
            buffer_write(_buffer, buffer_text, _value);
            buffer_write(_buffer, buffer_text, "\"");
        }
    }
    else
    {
        buffer_write(_buffer, buffer_text, " ");
        buffer_write(_buffer, buffer_text, string(_value));
    }
}