// Feather disable all
function __db_class() constructor
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

#macro DB_VERSION       "2.0.1"
#macro DB_DATE          "2025-01-29"
#macro DB_SAVE_VERSION  2

__db_trace($"Welcome to db by Juju Adams! This is version {DB_VERSION}, {DB_DATE}");
__db_trace($"This version will output version `{DB_SAVE_VERSION}` savefiles");
__db_trace($"This version will read version `1` and `2` savefiles");