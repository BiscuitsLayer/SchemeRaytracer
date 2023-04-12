#pragma once

#include <string>

#include "../window/window.hpp"

namespace Sim {

class Gui {
public:
    Gui(const std::string& window_title);

    void Cleanup() const;
    void Prepare() const;

    // This function changes context variables, so it is not const
    void Draw();

private:
    bool show_imgui_demo_window;
};

} // namespace Sim