#include "external.h"

#include <iostream>

int ReadFunction() {
    int ans = 0;
    std::cin >> ans;
    return ans;
}

int PrintFunction(int value) {
    std::cout << "Print function" << std::endl;
    std::cout << value << std::endl;
    return 777;
}

int PrintStringFunction(char* str) {
    std::cout << "Print string function" << std::endl;
    std::cout << str << std::endl;
    return 888;
}

int PrintObjectFunction(ObjectType* object) {
    if (object->type == 0) {
        std::cout << "Type = number" << std::endl;
        std::cout << object->number << std::endl;
    } else if (object->type == 1) {
        std::cout << "Type = boolean" << std::endl;
        std::cout << std::boolalpha << object->boolean << std::endl;
    } else if (object->type == 2) {
        std::cout << "Type = string" << std::endl;
        std::cout << object->str << std::endl;
    }
    return 999;
}
