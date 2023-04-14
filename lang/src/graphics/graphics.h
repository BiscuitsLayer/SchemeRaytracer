#ifdef __cplusplus
extern "C" {
#endif

void __GLInit();
void __GLClear() ;
void __GLPutPixel(int x, int y, unsigned char r, unsigned char g, unsigned char b);
bool __GLIsOpen();
void __GLDraw();
void __GLFinish();

#ifdef __cplusplus
}
#endif