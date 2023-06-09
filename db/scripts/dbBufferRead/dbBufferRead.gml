/// @param buffer

function DbBufferRead(_buffer)
{
    return __DbDeserialize(buffer_read(_buffer, buffer_string));
}