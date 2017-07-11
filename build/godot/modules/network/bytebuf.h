#ifndef BYTE_BUF_H
#define BYTE_BUF_H

#include <reference.h>
#include <dvector.h>
#include <io/stream_peer.h>

// C++ wrapper for ByteBuf
class ByteBuf : public Reference 
{
    OBJ_TYPE(ByteBuf, Reference)

public:
    ByteBuf();
    ~ByteBuf();

	void resize(int size);

    void writeInt32(int32_t p_val);
    int readInt32();

	DVector<uint8_t>& rawArray();

protected:
    static void _bind_methods();

    int     readIdx;
    int     writeIdx;
	DVector<uint8_t> data;
};

#endif // OPENSIMPLEX_NOISE_H


