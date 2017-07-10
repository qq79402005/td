#include "bytebuf.h"

ByteBuf::ByteBuf() : Reference(), readIdx(NULL), writeIdx(0), data_size(0){

}

ByteBuf::~ByteBuf() {
}

void ByteBuf::writeInt32(int value)
{
	memcpy(&data[writeIdx], &value, 4);
	writeIdx += 4;
}

void ByteBuf::resize(int size)
{
	data = new unsigned char[size];
	data_size = size;
}

int ByteBuf::readInt32()
{
    return 0;
}

// DVector<uint8_t> ByteBuf::rawArray()
// {
// 	DVector<uint8_t> result;
// 
// 	for( int i=0; i<data_size; i++)
// 		result.push_back(data[i]);
// }

void ByteBuf::_bind_methods() 
{
    ObjectTypeDB::bind_method(_MD("write_int32", "value"), &ByteBuf::writeInt32);
    //ObjectTypeDB::bind_method(_MD("set_seed", "seed"), &OsnNoise::set_seed);

    //ObjectTypeDB::bind_method(_MD("get_noise_2d", "x", "y"), &OsnNoise::get_noise_2d);
    //ObjectTypeDB::bind_method(_MD("get_noise_3d", "x", "y", "z"), &OsnNoise::get_noise_3d);
    //ObjectTypeDB::bind_method(_MD("get_noise_4d", "x", "y", "z", "w"), &OsnNoise::get_noise_4d);
}
