#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "DatabaseManager.h"
#include "GroupsModel.h"
#include "ItemsModel.h"
/*
 *  1. Add change picture to the menu of itemsView
 */
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    DatabaseManager db(&app);

    GroupsModel *groups = new GroupsModel(&app);
    qmlRegisterSingletonInstance("com.company.GroupsModel", 1, 0, "GroupsModel", groups);

    ItemsModel *items = new ItemsModel(&app);
    qmlRegisterSingletonInstance("com.company.ItemsModel", 1, 0, "ItemsModel", items);

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Forgetti", "Main");

    return app.exec();
}
