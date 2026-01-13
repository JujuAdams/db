// Feather disable all

/// Sets the metadata for a database. This will overwrite the existing metadata. Typically, you
/// will want to use a struct that contains further information (author, platform, etc.). Be aware
/// that this function sets the metadata by reference.
/// 
/// @param database
/// @param metadata

function db_set_metadata(_database, _metadata)
{
    _database.__metadata = _metadata;
}
