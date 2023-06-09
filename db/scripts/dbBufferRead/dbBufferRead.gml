/// @param buffer

function dbBufferRead(_buffer)
{
    return __dbDeserialize(buffer_read(_buffer, buffer_string));
}