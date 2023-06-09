/// @param database

function dbClear(_database)
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