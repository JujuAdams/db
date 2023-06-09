/// @param database
/// @param [ascii=false]

function DbDebugString(_database, _ascii = false)
{
    return __DbJSONVisualize(DbRawDataGet(_database), _ascii);
}