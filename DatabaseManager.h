#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QStandardPaths>
#include <QDir>
#include <QSqlDatabase>
#include <QSqlQuery>

class DatabaseManager
{
public:
    explicit DatabaseManager(QObject *parent = nullptr);

private:
    void create();
    void createTables();
    void insertValues();

public:
    static const QString docPath;
};

#endif // DATABASEMANAGER_H
