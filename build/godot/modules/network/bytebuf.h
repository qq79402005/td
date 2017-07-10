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

    void writeInt32(int value);
    int readInt32();

protected:
    static void _bind_methods();

    int     readIdx;
    int     writeIdx;
};

#endif // OPENSIMPLEX_NOISE_H


