#include <iostream>
#include <optional>

#include <GL/OOGL.hpp>

#include "gui/gui.hpp"
#include "window/window.hpp"

const int WIDTH = 640;
const int HEIGHT = 480;

int main() {
    std::string title{"MySimulator"};
    Sim::CustomWindow window{WIDTH, HEIGHT, title, GL::WindowStyle::Close};
    GL::Context& gl = window.GetContext();
    Sim::Gui gui{title};

    GL::Event ev;
    while (window.IsOpen()) {

        while (window.GetEvent( ev )) {
            if ((ev.Type == GL::Event::KeyDown) && (ev.Key.Code == GL::Key::Escape)) {
                window.Close();
            }
        }

        gl.Clear();
        gui.Prepare();

        gui.Draw();

        window.Present();
    }

    gui.Cleanup();
    return 0;
}