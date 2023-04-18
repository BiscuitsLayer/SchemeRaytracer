#ifdef __cplusplus
extern "C" {
#endif

enum ObjectType : int {
    TYPE_NUMBER = 0,
    TYPE_BOOLEAN = 1,
    TYPE_SYMBOL = 2,
    TYPE_CELL = 3
};

struct SchemeObject {
    ObjectType type;
    long long number;
    bool boolean;
    char* symbol;
    SchemeObject* first;
    SchemeObject* second;
};

void __GLInit();
void __GLClear() ;
void __GLPutPixel(int x, int y, unsigned char r, unsigned char g, unsigned char b);
bool __GLIsOpen();
void __GLDraw();
void __GLFinish();
void __GLPrint(SchemeObject* object);

#ifdef __cplusplus
}
#endif