#include "proxy_engine.h"


static bool running = false;



bool startProxy()
{
    running=true;

    return true;
}



bool stopProxy()
{
    running=false;

    return true;
}



bool getProxyStatus()
{
    return running;
}
