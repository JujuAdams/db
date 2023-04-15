/// @param database
/// @param pretty

function __db_serialize(_database, _pretty)
{
    return json_stringify(
    {
        database:  _database.__data,
        metadata:  _database.__metadata,
        timestamp: _database.__timestamp,
        version:   1,
    },
    _pretty);
}