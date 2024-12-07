#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QSqlDatabase>
#include <QSqlQuery>

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

private:
    void create();
    void createTables();
    void insertValues();

public:

    static const QString docPath;
signals:

};

#endif // DATABASEMANAGER_H
