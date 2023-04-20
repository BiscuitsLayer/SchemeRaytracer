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

void __GLInit();
void __GLClear() ;
void __GLPutPixel(SchemeObject* x, SchemeObject* y, SchemeObject* r, SchemeObject* g, SchemeObject* b);
SchemeObject __GLIsOpen();
void __GLDraw();
void __GLFinish();
void __GLPrint(SchemeObject* object);

#ifdef __cplusplus
}
#endif