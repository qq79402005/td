#include "bytebuf.h"
#include <io/marshalls.h>

ByteBuf::ByteBuf() : Reference(), readIdx(NULL), writeIdx(0){

}

ByteBuf::~ByteBuf() {
}

void ByteBuf::writeInt32(int32_t p_val)
{
	//big_endian
	p_val = BSWAP32(p_val);
	encode_uint32(p_val, &(data.write().ptr()[writeIdx]));
	writeIdx += 4;
}

void ByteBuf::resize(int size)
{
	data.resize(size);
}

int ByteBuf::readInt32()
{
    return 0;
}

DVector<uint8_t>& ByteBuf::rawArray()
{
	return data;
}

void ByteBuf::_bind_methods() 
{
	ObjectTypeDB::bind_method(_MD("resize", "size"), &ByteBuf::resize);
    ObjectTypeDB::bind_method(_MD("write_int32", "value"), &ByteBuf::writeInt32);
    ObjectTypeDB::bind_method(_MD("raw_data"), &ByteBuf::rawArray);
}
