#include "napi/native_api.h"
#include "proxy_engine.h"


static napi_value Start(
    napi_env env,
    napi_callback_info info
)
{
    startProxy();

    napi_value result;

    napi_get_boolean(
        env,
        true,
        &result
    );

    return result;
}



static napi_value Stop(
    napi_env env,
    napi_callback_info info
)
{
    stopProxy();

    napi_value result;

    napi_get_boolean(
        env,
        true,
        &result
    );

    return result;
}



static napi_value Status(
    napi_env env,
    napi_callback_info info
)
{
    bool value = getProxyStatus();

    napi_value result;

    napi_get_boolean(
        env,
        value,
        &result
    );

    return result;
}



EXTERN_C_START


static napi_value Init(
    napi_env env,
    napi_value exports
)
{

    napi_property_descriptor desc[] =
    {
        {
            "start",
            nullptr,
            Start,
            nullptr,
            nullptr,
            nullptr,
            napi_default,
            nullptr
        },

        {
            "stop",
            nullptr,
            Stop,
            nullptr,
            nullptr,
            nullptr,
            napi_default,
            nullptr
        },

        {
            "status",
            nullptr,
            Status,
            nullptr,
            nullptr,
            nullptr,
            napi_default,
            nullptr
        }
    };


    napi_define_properties(
        env,
        exports,
        3,
        desc
    );


    return exports;
}


EXTERN_C_END
