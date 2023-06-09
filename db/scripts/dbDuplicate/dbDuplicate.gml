function DbDuplicate(_database)
{
    var _new = new __DbClass();
    _new.__metadata = __DbDeepCopy(_database.__metadata);
    _new.__data     = __DbDeepCopy(_database.__data    );
    _new.__changed  = _database.__changed;
    return _new;
}