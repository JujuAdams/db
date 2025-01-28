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

#macro DB_VERSION       "2.0.0"
#macro DB_DATE          "2025-01-28"
#macro DB_SAVE_VERSION  2

show_debug_message($"db: Welcome to db by Juju Adams! This is version {DB_VERSION}, {DB_DATE}");
