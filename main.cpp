#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "DatabaseManager.h"
#include "GroupsModel.h"
/*
 * TODO: Make group buttons be checkable
 */
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    DatabaseManager db(&app);

    GroupsModel *groups = new GroupsModel(&app);
    qmlRegisterSingletonInstance("com.company.GroupsModel", 1, 0, "GroupsModel", groups);

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
