function dbDuplicate(_database)
{
    var _new = new __dbClass();
    _new.__metadata = __dbDeepCopy(_database.__metadata);
    _new.__data     = __dbDeepCopy(_database.__data    );
    _new.__changed  = _database.__changed;
    return _new;
}