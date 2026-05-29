// Feather disable all

/// @param initialData
/// @param defaultData

function __db_class(_initialData, _defaultData) constructor
{
    __metadata    = undefined;
    __data        = _initialData;
    __defaultData = _defaultData;
    __changed     = false;
    __timestamp   = date_current_datetime();
    
    static toString = function()
    {
        return "<database " + string_delete(string(ptr(self)), 1, 8) + ">";
    }
}

__db_trace($"Welcome to db by Juju Adams! This is version {DB_VERSION}, {DB_DATE}");
__db_trace($"This version will output version `{DB_SAVE_VERSION}` savefiles");
__db_trace($"This version will read version `1` and `2` savefiles");