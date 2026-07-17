@"
#include <napi/native_api.h>


  static napi_value StartProxy(
  napi_env env,
napi_callback_info info
)
{

  return nullptr;

}


static napi_value StopProxy(
  napi_env env,
napi_callback_info info
)
{

  return nullptr;

}


EXTERN_C_START

static napi_value Init(
  napi_env env,
napi_value exports
)
{

  return exports;

}

EXTERN_C_END


static napi_module demoModule =
  {
    1,
    0,
    nullptr,
    Init,
    "harmonyproxy",
    nullptr,
    {
    nullptr
  }
};


extern "C" __attribute__((constructor))
void RegisterModule()
{
  napi_module_register(&demoModule);
}
"@ | Set-Content entry\src\main\cpp\napi_bridge.cpp