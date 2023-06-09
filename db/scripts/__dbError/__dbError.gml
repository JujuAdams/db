function __dbError() 
{
	var _string = "db:\n";
    
	var _i = 0;
	repeat(argument_count)
	{
	    _string += string(argument[_i]);
	    ++_i;
	}
	
    show_error(_string + "\n ", true);
	return _string;
}