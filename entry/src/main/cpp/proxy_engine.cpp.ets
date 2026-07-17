@"
#include <string>


class ProxyEngine
{

  public:

    bool start()
{
  running=true;
  return true;
}


  bool stop()
{
  running=false;
  return true;
}


  bool status()
{
  return running;
}


  private:

    bool running=false;

};


ProxyEngine engine;
"@ | Set-Content entry\src\main\cpp\proxy_engine.cpp