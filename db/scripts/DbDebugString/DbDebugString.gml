/// @param database
/// @param [ascii=false]

function DbDebugString(_database, _ascii = false)
{
    return __DbJSONVisualization(DbRawDataGet(_database), _ascii);
}