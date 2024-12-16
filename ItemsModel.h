#ifndef ITEMSMODEL_H
#define ITEMSMODEL_H

#include <QSqlTableModel>
#include <QUrl>
#include <QFile>
#include <QSqlRecord>
#include <QSqlError>

#include "DatabaseManager.h"

class ItemsModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        idRole = Qt::UserRole + 1,
        nameRole,
        pictureSourceRole,
        groupIdRole
    };

    ItemsModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool add(const QString &name, const QString &pictureSource, const int &groupId);
    bool remove(const int &id);
    bool rename(const int &id, const QString &name);
    bool changePicture(const int &id, const QString &pictureSource);
    bool changeGroup(const int &id, const int &groupId);
};

#endif // ITEMSMODEL_H
