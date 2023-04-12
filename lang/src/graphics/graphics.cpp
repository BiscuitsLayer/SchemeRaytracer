#include "graphics.h"

#include <optional>

#include <GL/OOGL.hpp>

const int WIDTH = 100;
const int HEIGHT = 100;

unsigned char* pixels;
std::optional<GL::Window> window;
std::optional<GL::VertexBuffer> vbo;
std::optional<GL::VertexBuffer> ebo;
std::optional<GL::VertexArray> vao;
std::optional<GL::Program> program;

std::optional<GL::Image> image;
std::optional<GL::Texture> texture;

void __GLInit() {
    pixels = new unsigned char [WIDTH * HEIGHT * 4] (0u);
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

    image.emplace(WIDTH, HEIGHT, pixels);
    texture.emplace(image.value(), GL::InternalFormat::RGBA);

    program->SetUniform(program->GetUniform("textureImage"), GL_TEXTURE1);
    gl.BindTexture(texture.value(), GL_TEXTURE1);
}

void __GLClear() {
    GL::Context& gl = window->GetContext();
    gl.Clear();
}

void __GLPutPixel(int x, int y, unsigned char r, unsigned char g, unsigned char b) {
    if (0 <= x && x < WIDTH && 0 <= y && y < HEIGHT) {
        int position = (x + y * WIDTH) * 4;
        pixels[position] = r;
        pixels[position + 1] = g;
        pixels[position + 2] = b;
        pixels[position + 3] = 255;
    }
}

bool __GLIsOpen() {
    return window->IsOpen();
}

void __GLDraw() {
    GL::Event ev;
    while (window->GetEvent(ev)) {
        if ((ev.Type == GL::Event::KeyDown) && (ev.Key.Code == GL::Key::Escape)) {
            window->Close();
        }
    }

    GL::Context& gl = window->GetContext();

    image.emplace(WIDTH, HEIGHT, pixels);
    texture.emplace(image.value(), GL::InternalFormat::RGBA);

    program->SetUniform(program->GetUniform("textureImage"), GL_TEXTURE1);
    gl.BindTexture(texture.value(), GL_TEXTURE1);

    gl.DrawElements(vao.value(), GL::Primitive::Triangles, 0, 6, GL::Type::UnsignedInt);

    window->Present();
}