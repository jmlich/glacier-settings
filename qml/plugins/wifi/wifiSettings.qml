import QtQuick 2.0
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import MeeGo.Connman 0.2

Page {
    id: wifiSettingsPage
    property var modelData

    headerTools: HeaderToolsLayout {
        id: header
        showBackButton: true;
        title: qsTr("Connect to")+" "+modelData.name
    }

    TechnologyModel {
        id: networkingModel
        name: "wifi"
        property bool sheetOpened
        property string networkName
    }

    UserAgent {
        id: userAgent
        onUserInputRequested: {
            console.log("USER INPUT REQUESTED");
            var view = {
                "fields": []
            };
            for (var key in fields) {
                view.fields.push({
                                     "name": key,
                                     "id": key.toLowerCase(),
                                     "type": fields[key]["Type"],
                                     "requirement": fields[key]["Requirement"]
                                 });
                console.log(key + ":");
                for (var inkey in fields[key]) {
                    console.log("    " + inkey + ": " + fields[key][inkey]);
                }
            }
        }

        onErrorReported: {
            console.log("Got error from model: " + error);
        }
    }


    Component.onCompleted: {
        modelData.requestConnect();
        networkingModel.networkName.text = modelData.name;
    }

    Column{
        width: parent.width

        spacing: 24
        leftPadding: 24

        TextField{
            id: passphrase
            width: parent.width-48
        }

        Button{
            id: connectButton
            width: parent.width-48
            height: 48

            text: qsTr("Connect")
        }
    }
}
