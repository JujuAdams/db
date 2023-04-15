/// @param string

function __db_deserialize(_string)
{
    var _database = undefined;
    
    var _json = json_parse(_string);
    switch(_json.version)
    {
        case 1:
            _database = db_create(_json.metadata);
            db_set_data(_database, _json.data, false);
        break;
            
        default:
            __db_error("Unsupported version ", _json.version);
        break;
    }
    
    return _database;
}