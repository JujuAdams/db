function __dbClass() constructor
{
    __metadata  = undefined;
    __data      = undefined;
    __changed   = false;
    __timestamp = date_current_datetime();
    
    static toString = function()
    {
        return "<database " + string(ptr(self)) + ">";
    }
}