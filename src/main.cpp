#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif
#include <QtGui/QGuiApplication>


#include <QtQml>
#include <QtQuick/QQuickView>
#include <QtCore/QString>
#include <QScreen>
#include <QCoreApplication>

#include "models/settingsmodel.h"
#include "models/settingsproxymodel.h"

int main(int argc, char *argv[])
{
    setenv("QT_QUICK_CONTROLS_STYLE", "Nemo", 1);

    QGuiApplication app(argc, argv);
    QScreen* sc = app.primaryScreen();
    if(sc){
        sc->setOrientationUpdateMask(Qt::LandscapeOrientation
                             | Qt::PortraitOrientation
                             | Qt::InvertedLandscapeOrientation
                             | Qt::InvertedPortraitOrientation);
    }

    qmlRegisterType<SettingsModel>("org.nemomobile.glacier.settings",1,0,"SettingsModel");
    qmlRegisterType<SettingsProxyModel>("org.nemomobile.glacier.settings",1,0,"SettingsProxyModel");

    QQmlApplicationEngine* engine = new QQmlApplicationEngine(QUrl("/usr/share/glacier-settings/qml/glacier-settings.qml"));
    QObject *topLevel = engine->rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    engine->rootContext()->setContextProperty("__window", window);

    window->setTitle(QObject::tr("Settings"));
    window->showFullScreen();
    return app.exec();
}
