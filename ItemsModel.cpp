#include "ItemsModel.h"

ItemsModel::ItemsModel(QObject *parent, QSqlDatabase db)
    : QSqlTableModel(parent, db)
{
    setTable("Items");
}

QVariant ItemsModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case idRole:
        value = row;
        break;
    case nameRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case pictureSourceRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    case groupIdRole:
        value = QSqlTableModel::data(this->index(index.row(), 3));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> ItemsModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[nameRole] = "name";
    roles[pictureSourceRole] = "pictureSource";
    roles[groupIdRole] = "groupId";

    return roles;
}

bool ItemsModel::add(const QString &name, const QString &pictureSource, const int &groupId)
{
    bool submitting = false;

    QString localFilePath = QUrl(pictureSource).toLocalFile();
    QFile image(localFilePath);

    QString newImage = "";
    if(image.exists())
        newImage = DatabaseManager::docPath + "/item_images/" + QFileInfo(localFilePath).fileName();

    if(!newImage.isEmpty())
        image.copy(newImage);

    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("name", name);
    record.setValue("pictureSource", pictureSource);
    record.setValue("groupId", groupId);

    if(insertRecord(rowCount(), record)){

        submitting = submitAll();
        if(submitting == false){
            qWarning() << "Error adding item: " << lastError().text();
            revertAll();
        }

        select();
    }

    return submitting;
}

bool ItemsModel::remove(const int &id)
{
    QSqlTableModel model;

    model.setTable("items");
    model.setFilter("id = "+ QString::number(id));
    model.select();

    model.removeRow(0);

    select();

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error removing item: " << lastError().text();
        revertAll();
    }

    return submitting;
}

bool ItemsModel::rename(const int &id, const QString &name)
{
    QSqlTableModel model;

    model.setTable("items");
    model.setFilter("id = "+ QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("name", name);

    model.setRecord(0, record);

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error renaming item: " << lastError().text();
        revertAll();
    }

    select();

    return submitting;
}

bool ItemsModel::changePicture(const int &id, const QString &pictureSource)
{
    QSqlTableModel model;

    model.setTable("items");
    model.setFilter("id = "+ QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("pictureSource", pictureSource);

    model.setRecord(0, record);

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error changing picture of item: " << lastError().text();
        revertAll();
    }

    select();

    return submitting;
}

bool ItemsModel::changeGroup(const int &id, const int &groupId)
{
    QSqlTableModel model;

    model.setTable("items");
    model.setFilter("id = "+ QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("groupId", groupId);

    model.setRecord(0, record);

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error changing group of item: " << lastError().text();
        revertAll();
    }

    select();

    return submitting;
}

void ItemsModel::filterByGroup(const int &groupId)
{
    setFilter("groupId = " + QString::number(groupId));
    select();
}
