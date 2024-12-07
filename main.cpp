#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "DatabaseManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    DatabaseManager *db = new DatabaseManager(&app);
    qmlRegisterSingletonInstance("com.company.DatabaseManager", 1, 0 ,"DatabaseManager", db);

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
