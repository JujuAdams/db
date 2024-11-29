// Feather disable all

/// Sets the metadata for a database.
/// 
/// @param database
/// @param metadata

function db_set_metadata(_database, _metadata)
{
    _database.__metadata = _metadata;
}
