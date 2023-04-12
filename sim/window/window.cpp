#include "window.hpp"

namespace Sim {

CustomWindow::CustomWindow(GL::uint width, GL::uint height, const std::string& title, GL::WindowStyle::window_style_t style)
    : Window(width, height, title, style, WindowEventHandlerWithImGui) {}

LRESULT CALLBACK WindowEventHandlerWithImGui(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    if (ImGui_ImplWin32_WndProcHandler(hwnd, msg, wParam, lParam)) {
        return true;
    }

    CustomWindow* window;

    if (msg == WM_NCCREATE)
    {
        // Store pointer to associated Window class as userdata in Win32 window
        window = reinterpret_cast<CustomWindow*>(((LPCREATESTRUCT)lParam)->lpCreateParams);
        window->window = hwnd;

        SetWindowLongPtr(hwnd, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(window));

        return DefWindowProc(hwnd, msg, wParam, lParam);
    } else {
        window = reinterpret_cast<CustomWindow*>(GetWindowLongPtr(hwnd, GWLP_USERDATA));

        if (window != nullptr)
            return window->WindowEvent(msg, wParam, lParam);
        else
            return DefWindowProc(hwnd, msg, wParam, lParam);
    }
}

} // namespace Sim