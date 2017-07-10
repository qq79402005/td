#ifndef BYTE_BUF_H
#define BYTE_BUF_H

#include <reference.h>

// C++ wrapper for ByteBuf
class ByteBuf : public Reference 
{
    OBJ_TYPE(ByteBuf, Reference)

public:
    ByteBuf();
    ~ByteBuf();

	void resize(int size);

    void writeInt32(int value);
    int readInt32();

	//DVector<uint8_t> rawArray();

protected:
    static void _bind_methods();

    int     readIdx;
    int     writeIdx;
	int			   data_size;
	unsigned char* data;
};

#endif // OPENSIMPLEX_NOISE_H


