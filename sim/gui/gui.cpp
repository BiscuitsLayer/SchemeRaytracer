#include "gui.hpp"

// ImGui Implementation
#include <imgui_impl_win32.h>
#include <imgui_impl_opengl3.h>
#include <imgui_internal.h>
#include <imgui.h>

namespace Sim {

Gui::Gui(const std::string& window_title) {
    auto raw_window_handle = FindWindowA("OOGL_WINDOW", window_title.c_str());

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsClassic();
    // TODO: select ImGui style button
    //ImGui::StyleColorsDark();
    //ImGui::StyleColorsLight();

    ImGui_ImplWin32_Init(raw_window_handle);
    ImGui_ImplOpenGL3_Init();

    show_imgui_demo_window = false;
}

void Gui::Cleanup() const {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplWin32_Shutdown();
    ImGui::DestroyContext();
}

void Gui::Prepare() const {
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplWin32_NewFrame();
    ImGui::NewFrame();
}

void Gui::Draw() {
    ///// LEFT MENU /////

    const float displayWidth = ImGui::GetIO().DisplaySize.x;
    const float displayHeight = ImGui::GetIO().DisplaySize.y;

    float mainAreaTop = 0.0f;

    // Quick Hack: Added some padding to hide the window resize controls from right/bottom/top edge of the
    // window. When proper window docking is available in imgui use that instead.
    constexpr float HACK_PADDING = 0.0f; //9.0f;
    const float mainAreaHeight = displayHeight - mainAreaTop;
    const float windowHeight = mainAreaHeight + HACK_PADDING * 2u;
    const float windowPosY = mainAreaTop - HACK_PADDING;

    constexpr float MENU_DEFAULT_WIDTH_FACTOR = 30.0f;
    const float menuWidth = MENU_DEFAULT_WIDTH_FACTOR * ImGui::GetFontSize();

    ImGui::SetNextWindowSize(ImVec2(menuWidth, mainAreaHeight), ImGuiCond_FirstUseEver);
    ImGui::SetNextWindowSizeConstraints(ImVec2(0, -1), ImVec2(FLT_MAX, -1)); // Horizontal resize only

    ImGui::PushStyleVar(ImGuiStyleVar_WindowRounding, 0.0f);
    ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.0f, 0.0f));

    ImGui::Begin("Right Menu", nullptr,
        ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoTitleBar | /* ImGuiWindowFlags_NoScrollbar | */
        ImGuiWindowFlags_NoBringToFrontOnFocus);

    ImGui::PopStyleVar(2u); // Undo ImGui::PushStyleVar

    const float windowWidth = ImGui::GetWindowWidth();
    const float windowPosX = 0; //displayWidth - windowWidth + HACK_PADDING;

    // Keep the window glued to the right edge of the screen.
    ImGui::SetWindowSize(ImVec2(windowWidth, windowHeight));
    ImGui::SetWindowPos(ImVec2(windowPosX, windowPosY));

    const float menuContentWidth = ImGui::GetContentRegionAvail().x - HACK_PADDING;
    const float menuContentHeight = ImGui::GetContentRegionAvail().y - HACK_PADDING * 2u;

    ImGui::Dummy(ImVec2(0.0f, HACK_PADDING));

    ////////////////////////////////////////////////////////////////////////////////////////

    // DEMO WINDOW TOOLS

    if (show_imgui_demo_window) {
        ImGui::ShowDemoWindow(&show_imgui_demo_window);
    }
    ImGui::Checkbox("Demo Window", &show_imgui_demo_window);

    ImGui::End(); // Right Menu

    ImGui::EndFrame();
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

} // namespace Sim