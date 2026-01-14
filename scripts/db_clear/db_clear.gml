// Feather disable all

/// Removes all data from a database. If the database contained data then it will be marked as
/// changed.
/// 
/// @param database

function db_clear(_database)
{
    with(_database)
    {
        if (__data != undefined)
        {
            __data = undefined;
            __changed = true;
        }
    }
}
