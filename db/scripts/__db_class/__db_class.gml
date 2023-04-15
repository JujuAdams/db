/// @param metadata

function __db_class(_metadata) constructor
{
    __metadata = _metadata;
    __data     = undefined;
    __changed  = false;
    
    static toString = function()
    {
        return "<database " + string(ptr(self)) + ">";
    }
}