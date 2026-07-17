#ifndef HARMONY_LIBBOX_H
#define HARMONY_LIBBOX_H


#ifdef __cplusplus
extern "C" {
#endif


int box_start(
    const char* config
);


int box_stop();


int box_status();



#ifdef __cplusplus
}
#endif


#endif