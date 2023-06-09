function __dbDeserialize(_string)
{
    var _database = undefined;
    
    var _json = json_parse(_string);
    switch(_json.version)
    {
        case 1:
            _database = dbCreate();
            dbMetadataSet(_database, _json.metadata);
            dbRawDataSet(_database, _json.data, false);
            dbTimestampSet(_database, _json.timestamp);
        break;
            
        default:
            __dbError("Unsupported version ", _json.version);
        break;
    }
    
    return _database;
}