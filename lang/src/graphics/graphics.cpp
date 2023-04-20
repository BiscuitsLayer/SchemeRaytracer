#include "graphics.h"

#include <iostream>
#include <optional>
#include <cassert>

#include <GL/OOGL.hpp>

const int WIDTH = 100;
const int HEIGHT = 100;
const int CHANNELS = 4;
const long long PRECISION = 100;

std::shared_ptr<unsigned char[]> pixels;
std::optional<GL::Window> window;

std::optional<GL::VertexBuffer> ebo;
std::optional<GL::VertexBuffer> vbo;
std::optional<GL::Program> program;
std::optional<GL::VertexArray> vao;
std::optional<GL::Image> image;

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

    if (0 <= x && x < WIDTH && 0 <= y && y < HEIGHT) {
        int position = (x + y * WIDTH) * CHANNELS;
        pixels[position] = r;
        pixels[position + 1] = g;
        pixels[position + 2] = b;
        pixels[position + 3] = 255;
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

    image.emplace(WIDTH, HEIGHT, pixels.get());
    GL::Texture texture{image.value(), GL::InternalFormat::RGBA};

    program->SetUniform(program->GetUniform("textureImage"), GL_TEXTURE1);
    gl.BindTexture(texture, GL_TEXTURE1);

    gl.DrawElements(vao.value(), GL::Primitive::Triangles, 0, 6, GL::Type::UnsignedInt);

    window->Present();
}

void __GLFinish() {
    program.reset();
    vao.reset();
    ebo.reset();
    vbo.reset();
}

void __GLPrint(SchemeObject* object) {
    std::string value_to_print;
    if (!object) {
        value_to_print = "()";
    } else {
        switch(object->type) {
            case ObjectType::TYPE_NUMBER: {
                long long unhandled_value = object->number;
                if (unhandled_value % PRECISION == 0) {
                    long long value = unhandled_value / PRECISION;
                    value_to_print = std::to_string(value);
                } else {
                    double value = 1.0 * unhandled_value / PRECISION;
                    value_to_print = std::to_string(value);
                }
            } break;
            case ObjectType::TYPE_BOOLEAN: {
                value_to_print = object->boolean ? "#t" : "#f";
            } break;
            case ObjectType::TYPE_SYMBOL: {
                value_to_print = std::string{object->symbol};
            } break;
            case ObjectType::TYPE_CELL: {
                assert(false && "Printing cells is unimplemented");
            } break;
        }
    }
    
    std::cout << "Print: " << value_to_print << std::endl;
}