function DbLoad(_filename)
{
    if (!file_exists(_filename)) __DbError("Could not find \"", _filename, "\"");
    
    var _buffer   = undefined;
    var _database = undefined;
    
    try
    {
        _buffer = buffer_load(_filename);
        _database = __DbDeserialize(buffer_read(_buffer, buffer_text));
        buffer_delete(_buffer);
    }
    catch(_error)
    {
        
    }
    
    if ((_buffer != undefined) && (_buffer > 0)) buffer_delete(_buffer);
    
    return _database;
}