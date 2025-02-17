#include "DatabaseManager.h"

const QString DatabaseManager::docPath =
    QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);

DatabaseManager::DatabaseManager(QObject *parent)
{
    QDir documentsDir(docPath);
    if(!documentsDir.exists())
        documentsDir.mkpath(".");
    qWarning()<< documentsDir.path();
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("localhost");
    db.setDatabaseName(docPath + "/forgetti");

    bool ok = db.open("forgettiUser", "IloveForgetti!");

    if(!ok){
        qWarning() << "Problem occured while connecting to db!";
        exit(-1);
    }

    if(db.tables().isEmpty()){
        create();
        qWarning() <<"CREATING";
    }
}

void DatabaseManager::create()
{
    createTables();

    #ifndef NDEBUG
        insertValues();
    #endif
}

void DatabaseManager::createTables()
{
    QSqlQuery query;

    QString groupTable = "CREATE TABLE Groups("
                         " id INTEGER PRIMARY KEY AUTOINCREMENT,"
                         " name TEXT NOT NULL,"
                         " isFavorite INTEGER DEFAULT 0);";
    if(!query.exec(groupTable))
        qWarning()<< "Error creating group table...";

    QString itemsTable = "CREATE TABLE Items("
                         " id INTEGER PRIMARY KEY AUTOINCREMENT,"
                         " name TEXT,"
                         " pictureSource TEXT,"
                         " groupId INTEGER NOT NULL,"
                         " FOREIGN KEY (groupId) REFERENCES Groups(id) ON DELETE CASCADE);";
    if(!query.exec(itemsTable))
        qWarning()<< "Error creating items table...";
}

void DatabaseManager::insertValues()
{
    QSqlQuery query;

    QString groupsInsert = "INSERT INTO Groups(name) VALUES"
                             " (\"Leaving home\"),"
                             " (\"Leaving office\"),"
                             " (\"Going to the Gym\"),"
                             " (\"Leaving university\");";
    if(!query.exec(groupsInsert))
        qWarning()<< "Problem while adding to Groups table...";

    QString itemsInsert = "INSERT INTO Items(name, groupId) VALUES"
                           " (\"Phone\", 1),"
                           " (\"Keys\", 1),"
                           " (\"Wallet\", 1),"
                           " (\" Phone\", 3);";
    if(!query.exec(itemsInsert))
        qWarning()<< "Problem while adding to Items table...";
}
