#include "bytebuf.h"

ByteBuf::ByteBuf() : Reference(), readIdx(NULL), writeIdx(0) {

}

ByteBuf::~ByteBuf() {
}

void ByteBuf::writeInt32(int value)
{

}

int ByteBuf::readInt32()
{
    return 0;
}

void ByteBuf::_bind_methods() 
{
    ObjectTypeDB::bind_method(_MD("write_int32", "value"), &ByteBuf::writeInt32);
    //ObjectTypeDB::bind_method(_MD("set_seed", "seed"), &OsnNoise::set_seed);

    //ObjectTypeDB::bind_method(_MD("get_noise_2d", "x", "y"), &OsnNoise::get_noise_2d);
    //ObjectTypeDB::bind_method(_MD("get_noise_3d", "x", "y", "z"), &OsnNoise::get_noise_3d);
    //ObjectTypeDB::bind_method(_MD("get_noise_4d", "x", "y", "z", "w"), &OsnNoise::get_noise_4d);
}
