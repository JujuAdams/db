/// @param metadata
/// @param timestamp

function __db_class(_metadata) constructor
{
    __metadata  = _metadata;
    __data      = undefined;
    __changed   = false;
    __timestamp = date_current_datetime();
    
    static toString = function()
    {
        return "<database " + string(ptr(self)) + ">";
    }
}