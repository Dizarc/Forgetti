cmake_minimum_required(VERSION 3.16)

project(Forgetti VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appForgetti
    application.qrc
    main.cpp
    DatabaseManager.h DatabaseManager.cpp
    GroupsModel.h GroupsModel.cpp
    ItemsModel.h ItemsModel.cpp
)

qt_add_qml_module(appForgetti
    URI Forgetti
    VERSION 1.0

    QML_FILES
        Main.qml
        GroupsView.qml
        ItemsView.qml

        custom/RenameDialog.qml
        custom/DeleteDialog.qml

    RESOURCES
        qtquickcontrols2.conf
)

# Qt for iOS sets MACOSX_BUN
#DLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appForgetti PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appForgetti
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appForgetti
    PRIVATE Qt6::Quick
            Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appForgetti
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
