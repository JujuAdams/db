function db_duplicate(_database)
{
    var _new = new __db_class();
    _new.__metadata = SnapDeepCopy(_database.__metadata);
    _new.__data     = SnapDeepCopy(_database.__data    );
    _new.__changed  = _database.__changed;
    return _new;
}