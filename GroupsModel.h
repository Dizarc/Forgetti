#ifndef GROUPSMODEL_H
#define GROUPSMODEL_H

#include <QSqlTableModel>
#include <QSqlRecord>
#include <QSqlError>

class GroupsModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        idRole = Qt::UserRole + 1,
        nameRole
    };

    GroupsModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool add(const QString &name);
};

#endif // GROUPSMODEL_H
