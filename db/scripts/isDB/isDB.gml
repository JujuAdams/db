/// @param value

function IsDb(_value)
{
    return (is_struct(_value) && (instanceof(_value) == "__DbClass"));
}