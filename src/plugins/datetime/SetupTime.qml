/*
 * Copyright (C) 2021-2022 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */
import QtQuick 2.6
import Nemo
import Nemo.Controls

import org.nemomobile.systemsettings 1.0

import org.nemomobile.glacier.settings 1.0

import Glacier.Controls.Settings 1.0

Page {
    id: dataTimeSetupTime

    headerTools: HeaderToolsLayout {
        showBackButton: true;
        title: qsTr("Setup time")
    }

    DateTimeSettings{
        id: dateTimeSettings
    }

    SettingsColumn {
        id: dataSettingsColumn
        anchors.fill: parent

        TextField{
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(new Date(), "HH:mm");
            width: Theme.itemWidthSmall
            horizontalAlignment: TextInput.AlignHCenter
            inputMethodHints: Qt.ImhDigitsOnly
            inputMask: "00:00;_"

            onEditingFinished: {
                var values = text.split(":")
                dateTimeSettings.setTime(values[0], values[1])
                console.log("setTime: " + text)
            }
        }

    }
}
