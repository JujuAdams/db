function __dbTrace() 
{
	var _string = "db: ";
    
	var _i = 0;
	repeat(argument_count)
	{
	    _string += string(argument[_i]);
	    ++_i;
	}
	
    show_debug_message(_string);
	return _string;
}