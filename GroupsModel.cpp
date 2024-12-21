#include "GroupsModel.h"

GroupsModel::GroupsModel(QObject *parent, QSqlDatabase db)
    : QSqlTableModel(parent, db)
{
    setTable("Groups");
    select();
}

QVariant GroupsModel::data(const QModelIndex &index, int role) const
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
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> GroupsModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[nameRole] = "name";

    return roles;
}

bool GroupsModel::add(const QString &name){

    bool submitting = false;

    insertRow(rowCount() + 1);

    QSqlRecord record = this->record(rowCount());

    record.setValue("name", name);

    if(insertRecord(rowCount(), record)){

        submitting = submitAll();
        if(submitting == false){
            qWarning() << "Error adding group: " << lastError().text();
            revertAll();
        }

        select();
    }
    return submitting;
}

bool GroupsModel::remove(const int &id)
{
    QSqlTableModel model;

    model.setTable("Groups");
    model.setFilter("id = " + QString::number(id));
    model.select();
    model.removeRow(0);

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error removing group: " << lastError().text();
        revertAll();
    }

    select();

    return submitting;
}

bool GroupsModel::rename(const int &id, const QString &name)
{
    QSqlTableModel model;

    model.setTable("Groups");
    model.setFilter("id = " + QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("name", name);

    model.setRecord(0, record);

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error renaming group: " << lastError().text();
        revertAll();
    }

    select();

    return submitting;
}
