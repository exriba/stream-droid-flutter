#include "flutter_window.h"
#include <windows.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>

#include <optional>

#include "flutter/generated_plugin_registrant.h"

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    : project_(project) {}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate() {
  if (!Win32Window::OnCreate()) {
    return false;
  }

  RECT frame = GetClientArea();

  // The size here must match the window dimensions to avoid unnecessary surface
  // creation / destruction in the startup path.
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project_);
  // Ensure that basic setup of the controller was successful.
  if (!flutter_controller_->engine() || !flutter_controller_->view()) {
    return false;
  }
  RegisterPlugins(flutter_controller_->engine());
  SetChildContent(flutter_controller_->view()->GetNativeWindow());

  // --- METHOD CHANNEL FOR SERVICE CHECK ---
  auto serviceChannel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
    flutter_controller_->engine()->messenger(), "stream_droid.service_control", &flutter::StandardMethodCodec::GetInstance());

  serviceChannel->SetMethodCallHandler(
    [](const flutter::MethodCall<flutter::EncodableValue>& call,
       std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {

      std::string serviceName;

      if (const auto* args = std::get_if<flutter::EncodableMap>(call.arguments())) {
        auto it = args->find(flutter::EncodableValue("serviceName"));
        if (it != args->end()) {
          if (const std::string* name = std::get_if<std::string>(&it->second)) {
            serviceName = *name;
          }
        }
      }

      if (serviceName.empty()) {
        result->Error("invalid_argument", "serviceName cannot be empty");
        return;
      }

      if (call.method_name() == "isServiceRunning") {
        bool running = false;
        SC_HANDLE scm = OpenSCManager(nullptr, nullptr, SC_MANAGER_CONNECT);
        if (scm) {
          SC_HANDLE service = OpenServiceA(scm, serviceName.c_str(), SERVICE_QUERY_STATUS);
          if (service) {
            SERVICE_STATUS status;
            if (QueryServiceStatus(service, &status)) {
              running = (status.dwCurrentState == SERVICE_RUNNING);
            }
            CloseServiceHandle(service);
          }
          CloseServiceHandle(scm);
        }
        result->Success(flutter::EncodableValue(running));

      } else {
        result->NotImplemented();
      }
    });

  flutter_controller_->engine()->SetNextFrameCallback([&]() {
    this->Show();
  });

  // Flutter can complete the first frame before the "show window" callback is
  // registered. The following call ensures a frame is pending to ensure the
  // window is shown. It is a no-op if the first frame hasn't completed yet.
  flutter_controller_->ForceRedraw();

  return true;
}

void FlutterWindow::OnDestroy() {
  if (flutter_controller_) {
    flutter_controller_ = nullptr;
  }

  Win32Window::OnDestroy();
}

LRESULT
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              WPARAM const wparam,
                              LPARAM const lparam) noexcept {
  // Give Flutter, including plugins, an opportunity to handle window messages.
  if (flutter_controller_) {
    std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      lparam);
    if (result) {
      return *result;
    }
  }

  switch (message) {
    case WM_FONTCHANGE:
      flutter_controller_->engine()->ReloadSystemFonts();
      break;
  }

  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}
