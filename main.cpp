#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "DatabaseManager.h"
#include "GroupsModel.h"
#include "ItemsModel.h"
/*
 *  1. Make itemsView show up in a gridlike way with the pictures of the items on it.
 *  2. Add change picture to the menu of itemsView
 *  3. Make the add new Item in itemView open up a dialog that allows picture taking
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
