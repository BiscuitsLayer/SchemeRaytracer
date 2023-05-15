#pragma once
#include <cstdint>

#ifdef __cplusplus
extern "C" {
#endif

constexpr int64_t PRECISION = 100;

enum ObjectType : int64_t {
    TYPE_NUMBER = 0,
    TYPE_BOOLEAN = 1,
    TYPE_SYMBOL = 2,
    TYPE_CELL = 3
};

enum FieldType : int64_t {
    FIELD_TYPE = 0,
    FIELD_NUMBER = 1,
    FIELD_BOOLEAN = 2,
    FIELD_SYMBOL = 3,
    FIELD_FIRST = 4,
    FIELD_SECOND = 5
};

struct SchemeObject {
    ObjectType type;
    int64_t number;
    bool boolean;
    char* symbol;
    SchemeObject* first;
    SchemeObject* second;
};

// Graphics
void __GLInit();
void __GLClear() ;
void __GLPutPixel(SchemeObject* x_object, SchemeObject* y_object, SchemeObject* r_object, SchemeObject* g_object, SchemeObject* b_object);
SchemeObject __GLIsOpen();
void __GLDraw();
void __GLFinish();

// Print
void __GLPrint(SchemeObject* object);

// Assert
void __GLAssert(bool value);

// Math
SchemeObject __GLExpt(SchemeObject* value_object, SchemeObject* power_object);
SchemeObject __GLSqrt(SchemeObject* object);

#ifdef __cplusplus
}
#endif