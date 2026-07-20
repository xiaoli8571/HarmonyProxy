#include <napi/native_api.h>
#include <hilog/log.h>

#include "libbox.h"
#include "proxy_engine.h"

#define LOG_TAG "HarmonyProxy"

static napi_value Start(
    napi_env env,
    napi_callback_info info
)
{
    OH_LOG_INFO(
        LOG_APP,
        "HarmonyProxy Native Start ENTER"
    );

    size_t argc = 1;
    napi_value args[1];

    napi_get_cb_info(
        env,
        info,
        &argc,
        args,
        nullptr,
        nullptr
    );

    if(argc < 1)
    {
        OH_LOG_ERROR(
            LOG_APP,
            "Start config missing"
        );

        napi_value result;
        napi_get_boolean(
            env,
            false,
            &result
        );
        return result;
    }

    char buffer[8192]={0};
    size_t length=0;

    napi_get_value_string_utf8(
        env,
        args[0],
        buffer,
        sizeof(buffer),
        &length
    );

    OH_LOG_INFO(
        LOG_APP,
        "config length=%{public}zu",
        length
    );

    int ret = BoxStart(buffer);

    OH_LOG_INFO(
        LOG_APP,
        "BoxStart ret=%{public}d",
        ret
    );

    if (ret != 0) {
        char* errMsg = BoxGetLastError();
        OH_LOG_ERROR(
            LOG_APP,
            "BoxStart FAILED ret=%{public}d error=%{public}s",
            ret,
            errMsg ? errMsg : "unknown"
        );
    }

    napi_value result;
    napi_get_boolean(
        env,
        ret == 0,
        &result
    );

    return result;
}

static napi_value Stop(
    napi_env env,
    napi_callback_info info
)
{
    OH_LOG_INFO(
        LOG_APP,
        "HarmonyProxy Stop"
    );

    int ret = BoxStop();

    napi_value result;
    napi_get_boolean(
        env,
        ret == 0,
        &result
    );

    return result;
}

static napi_value Status(
    napi_env env,
    napi_callback_info info
)
{
    int status = BoxStatus();

    napi_value result;
    napi_get_boolean(
        env,
        status == 1,
        &result
    );

    return result;
}

static napi_value Version(
    napi_env env,
    napi_callback_info info
)
{
    char* ver = BoxVersion();
    OH_LOG_INFO(
        LOG_APP,
        "libbox version=%{public}s",
        ver
    );

    napi_value result;
    napi_create_string_utf8(
        env,
        ver,
        NAPI_AUTO_LENGTH,
        &result
    );

    return result;
}

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
        },
        {
            "version",
            nullptr,
            Version,
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
        sizeof(desc) / sizeof(desc[0]),
        desc
    );

    OH_LOG_INFO(
        LOG_APP,
        "HarmonyProxy NAPI Init success"
    );

    return exports;
}

/*
 * HarmonyOS NAPI registration
 */
EXTERN_C_START

static napi_module proxyModule =
{
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = nullptr,
    .reserved = {0},
};

EXTERN_C_END

extern "C"
__attribute__((constructor))
void RegisterProxyModule()
{
    napi_module_register(
        &proxyModule
    );
}
