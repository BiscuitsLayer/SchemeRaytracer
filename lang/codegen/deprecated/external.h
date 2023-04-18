#ifdef __cplusplus
extern "C" {
#endif

// 0 - number
// 1 - bool
// 2 - string
// 3 - cell?

struct ObjectType {
    int type;
    long long number;
    bool boolean;
    char* str;
    ObjectType* next;
};

int ReadFunction();
int PrintFunction(int value);
int PrintStringFunction(char* str);
int PrintObjectFunction(ObjectType* object);


#ifdef __cplusplus
}
#endif