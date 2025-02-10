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
        nameRole,
        isFavoriteRole
    };

    GroupsModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool add(const QString &name);
    bool remove(const int &id);
    bool rename(const int &id, const QString &name);
    bool changeFavorite(const int &id, const int &favorite);
};

#endif // GROUPSMODEL_H
