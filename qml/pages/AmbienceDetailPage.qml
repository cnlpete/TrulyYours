/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    property string url: ""
    property string name: ""
    property bool savingInProgress: false
    Component.onCompleted: {
        ambienceMgr.saveFullImageSucceeded.connect(page.setSource)
        ambienceMgr.saveImageToGallerySucceeded.connect(page.stopBusyIndicator)
        ambienceMgr.saveFullImage(url, name);

    }
    SilicaFlickable {
        id: ambienceDetailed
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: fullImage.height

        PullDownMenu {
            MenuItem {
                text: qsTr("Save and create ambience")
                visible: fullImage.source != "" && !savingInProgress
                onClicked: {
                    savingInProgress = true;
                    ambienceMgr.saveImageToGalleryAndApplyAmbience(name)
                }
            }

            MenuItem {
                text: qsTr("Save to gallery")
                visible: fullImage.source != "" && !savingInProgress
                onClicked: {
                    savingInProgress = true;
                    ambienceMgr.saveImageToGallery(name)
                }
            }
        }

        VerticalScrollDecorator {}

        Image {
            id: fullImage
            height: 1600
            width: 540
            source: ""
            sourceSize.height: height
            sourceSize.width: width
        }
    }
    BusyIndicator {
        anchors.centerIn: parent
        running: fullImage.source == "" || savingInProgress
    }

    function setSource(url)
    {
        fullImage.source = url;
    }

    function stopBusyIndicator()
    {
        savingInProgress = false
    }
}





