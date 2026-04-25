// Feather disable all

function __db_error() 
{
	var _string = $"db {DB_VERSION}:\n";
    
	var _i = 0;
	repeat(argument_count)
	{
	    _string += string(argument[_i]);
	    ++_i;
	}
	
    show_error(" \n" + _string + "\n ", true);
	return _string;
}
