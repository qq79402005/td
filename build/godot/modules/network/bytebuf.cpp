#include "bytebuf.h"
#include <io/marshalls.h>

ByteBuf::ByteBuf() : Reference(), readIdx(0), writeIdx(0){

}

ByteBuf::~ByteBuf() {
}

void ByteBuf::write_byte(uint8_t p_val)
{
	data.push_back(p_val);
	writeIdx += 1;
}

void ByteBuf::write_i32(int32_t p_val)
{
	//big_endian
	data.resize(data.size()+4);
	p_val = BSWAP32(p_val);
	encode_uint32(p_val, &(data.write().ptr()[writeIdx]));
	writeIdx += 4;
}

int32_t ByteBuf::read_i32()
{
	uint32_t r = decode_uint32(&(data.write().ptr()[readIdx]));
	r = BSWAP32(r);
	readIdx += 4;

	return r;
}

DVector<uint8_t>& ByteBuf::raw_data()
{
	return data;
}

void ByteBuf::_bind_methods() 
{
	ObjectTypeDB::bind_method(_MD("write_byte", "byte"), &ByteBuf::write_byte);
    ObjectTypeDB::bind_method(_MD("write_i32", "value"), &ByteBuf::write_i32);
	ObjectTypeDB::bind_method(_MD("read_i32"), &ByteBuf::read_i32);
    ObjectTypeDB::bind_method(_MD("raw_data"), &ByteBuf::raw_data);
}
