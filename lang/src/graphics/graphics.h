#include <cstdint>

#ifdef __cplusplus
extern "C" {
#endif

enum ObjectType : int64_t {
    TYPE_NUMBER = 0,
    TYPE_BOOLEAN = 1,
    TYPE_SYMBOL = 2,
    TYPE_CELL = 3
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