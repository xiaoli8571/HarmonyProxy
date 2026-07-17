#include "../include/libbox.h"


static int running=0;



int box_start(
    const char* config
)
{

    running=1;

    return 0;

}



int box_stop()
{

    running=0;

    return 0;

}



int box_status()
{

    return running;

}