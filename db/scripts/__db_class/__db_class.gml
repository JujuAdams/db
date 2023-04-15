function __db_class() constructor
{
    __metadata = undefined;
    __data     = undefined;
    __changed  = false;
    
    static toString = function()
    {
        return "<database " + string(ptr(self)) + ">";
    }
}