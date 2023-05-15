#define NOMINMAX

#include "external.hpp"

#include <iostream>
#include <optional>
#include <cassert>

#include <GL/OOGL.hpp>

const int WIDTH = 100;
const int HEIGHT = 100;
const int CHANNELS = 4;

std::shared_ptr<unsigned char[]> pixels;

// OPENGL STRUCTS
std::optional<GL::Window> window;
std::optional<GL::VertexBuffer> ebo;
std::optional<GL::VertexBuffer> vbo;
std::optional<GL::Program> program;
std::optional<GL::VertexArray> vao;
std::optional<GL::Image> image;
std::optional<GL::Texture> texture;

void __GLInit() {
    pixels = std::make_shared<unsigned char[]>(WIDTH * HEIGHT * CHANNELS, 0u);
    window.emplace(WIDTH, HEIGHT, "OpenGLWindow", GL::WindowStyle::Close);
    GL::Context& gl = window->GetContext();

    GL::Shader vert(GL::ShaderType::Vertex,
        "#version 330 core\n"
        "in vec2 position;\n"
        "in vec2 texCoord;\n"
        "out vec2 TexCoord;\n"
        "void main()\n"
        "{\n"
        "   gl_Position = vec4(position.x, position.y, 0.0, 1.0);\n"
        "   TexCoord = texCoord;\n"
        "}\0"
    );
    GL::Shader frag(GL::ShaderType::Fragment,
        "#version 330 core\n"
        "in vec2 TexCoord;\n"
        "out vec4 FragColor;\n"
        "uniform sampler2D textureImage;\n"
        "void main()\n"
        "{\n"
        "   FragColor = texture(textureImage, TexCoord);\n"
        "}\0"
    );
    
    program.emplace(vert, frag);

    float vertices[] = {
        -1.0f, -1.0f,  0.0f,  0.0f,
         1.0f, -1.0f,  1.0f,  0.0f,
         1.0f,  1.0f,  1.0f,  1.0f,
        -1.0f,  1.0f,  0.0f,  1.0f,
    };
    vbo.emplace(vertices, sizeof(vertices), GL::BufferUsage::StaticDraw);

    unsigned int indices[] = {
        0, 1, 2, 0, 2, 3
    };
    ebo.emplace(indices, sizeof(indices), GL::BufferUsage::StaticDraw);

    vao.emplace();
    vao->BindAttribute(program->GetAttribute("position"), vbo.value(), GL::Type::Float, 2, 4 * sizeof(float), 0 * sizeof(float));
    vao->BindAttribute(program->GetAttribute("texCoord"), vbo.value(), GL::Type::Float, 2, 4 * sizeof(float), 2 * sizeof(float));
    vao->BindElements(ebo.value());

    image.emplace(WIDTH, HEIGHT, pixels.get());
    texture.emplace(image.value(), GL::InternalFormat::RGBA);
}

void __GLClear() {
    GL::Context& gl = window->GetContext();
    gl.Clear();
}

void __GLPutPixel(SchemeObject* x_object, SchemeObject* y_object, SchemeObject* r_object, SchemeObject* g_object, SchemeObject* b_object) {
    assert(x_object->type == ObjectType::TYPE_NUMBER);
    assert(x_object->number % PRECISION == 0);
    int x = x_object->number / PRECISION;

    assert(y_object->type == ObjectType::TYPE_NUMBER);
    assert(y_object->number % PRECISION == 0);
    int y = y_object->number / PRECISION;

    assert(r_object->type == ObjectType::TYPE_NUMBER);
    int r = r_object->number / PRECISION;

    assert(g_object->type == ObjectType::TYPE_NUMBER);
    int g = g_object->number / PRECISION;

    assert(b_object->type == ObjectType::TYPE_NUMBER);
    int b = b_object->number / PRECISION;

    if (image.has_value()) {
        image->SetPixel(x, y, GL::Color{static_cast<GL::uchar>(r), static_cast<GL::uchar>(g), static_cast<GL::uchar>(b)});
    }
}

SchemeObject __GLIsOpen() {
    SchemeObject ans;
    ans.type = ObjectType::TYPE_BOOLEAN;
    ans.boolean = window->IsOpen();
    return ans;
}

void __GLDraw() {
    GL::Event ev;
    while (window->GetEvent(ev)) {
        if ((ev.Type == GL::Event::KeyDown) && (ev.Key.Code == GL::Key::Escape)) {
            window->Close();
        }
    }

    GL::Context& gl = window->GetContext();

    texture.emplace(image.value(), GL::InternalFormat::RGBA);

    program->SetUniform(program->GetUniform("textureImage"), GL_TEXTURE1);
    gl.BindTexture(texture.value(), static_cast<GL::uchar>(GL_TEXTURE1));

    gl.DrawElements(vao.value(), GL::Primitive::Triangles, 0, 6, GL::Type::UnsignedInt);

    window->Present();
}

void __GLFinish() {
    program.reset();
    vao.reset();
    ebo.reset();
    vbo.reset();

    texture.reset();
    image.reset();

    window.reset();
}

// Auxiliary functions for print formatting
std::string GLObjectToString(SchemeObject* object);
std::string GLListToString(SchemeObject* object);

void __GLPrint(SchemeObject* object) {
    std::cout << "Print: " << GLObjectToString(object) << std::endl;
}

std::string GLObjectToString(SchemeObject* object) {
    std::string ans{};

    if (!object) {
        ans = "()";
    } else {
        switch(object->type) {
            case ObjectType::TYPE_NUMBER: {
                number_t unhandled_value = object->number;
                if (unhandled_value % PRECISION == 0) {
                    number_t value = unhandled_value / PRECISION;
                    ans = std::to_string(value);
                } else {
                    double value = 1.0 * unhandled_value / PRECISION;
                    ans = std::to_string(value);
                }
            } break;
            case ObjectType::TYPE_BOOLEAN: {
                ans = object->boolean ? "#t" : "#f";
            } break;
            case ObjectType::TYPE_SYMBOL: {
                ans = std::string{object->symbol};
            } break;
            case ObjectType::TYPE_CELL: {
                ans = GLListToString(object);
            } break;
        }
    }

    return ans;
}

std::string GLListToString(SchemeObject* object) {
    std::string ans = "(";

    for (SchemeObject* cell = object; cell; cell = cell->second) {
        SchemeObject* first = cell->first;
        if (!first) {
            ans += ")";
            return ans;
        }

        std::string value = GLObjectToString(first);
        SchemeObject* second = cell->second;
        if (!second) {
            ans += value + ")";
            return ans;
        } else {
            ans += value + " ";
            if (second->type != ObjectType::TYPE_CELL) {  // If second is not Cell, we should use Dot
                value = GLObjectToString(second); 
                ans += ". " + value + ")";
                return ans;
            }
        }
    }

    return ans;
}

void __GLAssert(bool value) {
    assert(value);
}

SchemeObject __GLExpt(SchemeObject* value_object, SchemeObject* power_object) {
    SchemeObject ans;
    ans.type = ObjectType::TYPE_NUMBER;

    assert(value_object->type == ObjectType::TYPE_NUMBER);
    double value_number = static_cast<double>(value_object->number) / PRECISION;

    assert(power_object->type == ObjectType::TYPE_NUMBER);
    double power_number = static_cast<double>(power_object->number) / PRECISION;

    ans.number = std::pow(value_number, power_number) * PRECISION;
    return ans;
}

SchemeObject __GLSqrt(SchemeObject* value_object) {
    SchemeObject ans;
    ans.type = ObjectType::TYPE_NUMBER;

    assert(value_object->type == ObjectType::TYPE_NUMBER);
    double value_number = static_cast<double>(value_object->number) / PRECISION;

    ans.number = std::sqrt(value_number) * PRECISION;
    return ans;
}

SchemeObject __GLMax(SchemeObject* lhs, SchemeObject* rhs) {
    SchemeObject ans;
    ans.type = ObjectType::TYPE_NUMBER;

    assert(lhs->type == ObjectType::TYPE_NUMBER);
    double lhs_number = static_cast<double>(lhs->number) / PRECISION;

    assert(rhs->type == ObjectType::TYPE_NUMBER);
    double rhs_number = static_cast<double>(rhs->number) / PRECISION;

    ans.number = std::max(lhs_number, rhs_number) * PRECISION;
    return ans;
}

SchemeObject __GLMin(SchemeObject* lhs, SchemeObject* rhs) {
    SchemeObject ans;
    ans.type = ObjectType::TYPE_NUMBER;

    assert(lhs->type == ObjectType::TYPE_NUMBER);
    double lhs_number = static_cast<double>(lhs->number) / PRECISION;

    assert(rhs->type == ObjectType::TYPE_NUMBER);
    double rhs_number = static_cast<double>(rhs->number) / PRECISION;

    ans.number = std::min(lhs_number, rhs_number) * PRECISION;
    return ans;
}