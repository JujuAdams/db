function __DbDeserialize(_string)
{
    var _database = undefined;
    
    var _json = json_parse(_string);
    switch(_json.version)
    {
        case 1:
            _database = DbCreate();
            DbMetadataSet(_database, _json.metadata);
            DbRawDataSet(_database, _json.data, false);
            DbTimestampSet(_database, _json.timestamp);
        break;
            
        default:
            __DbError("Unsupported version ", _json.version);
        break;
    }
    
    return _database;
}