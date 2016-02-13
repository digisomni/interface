//
//  DefaultFrame.qml
//
//  Created by Bradley Austin Davis on 12 Jan 2016
//  Copyright 2016 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

import QtQuick 2.5
import QtGraphicalEffects 1.0

import "."
import "../controls-uit"
import "../styles-uit"

Frame {
    id: frame
    HifiConstants { id: hifi }

    property bool wideTopMargin: (window && (window.closable || window.title));

    Rectangle {
        // Dialog frame
        id: frameContent
        anchors { margins: -iconSize; topMargin: -iconSize * (wideTopMargin ? 2 : 1); }
        anchors.fill: parent
        color: hifi.colors.baseGrayHighlight40
        border {
            width: hifi.dimensions.borderWidth
            color: hifi.colors.faintGray50
        }
        radius: hifi.dimensions.borderRadius

        // Allow dragging of the window
        MouseArea {
            anchors.fill: parent
            drag.target: window
        }

        Row {
            id: controlsRow
            anchors { right: parent.right; top: parent.top; rightMargin: iconSize; topMargin: iconSize / 2; }
            spacing: iconSize / 4

            HiFiGlyphs {
                // "Pin" button
                visible: false
                text: (frame.pinned && !pinClickArea.containsMouse) || (!frame.pinned && pinClickArea.containsMouse) ? "z" : "y"
                color: pinClickArea.containsMouse && !pinClickArea.pressed ? hifi.colors.redHighlight : hifi.colors.white
                size: frame.iconSize
                MouseArea {
                    id: pinClickArea
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: true
                    onClicked: { frame.pin(); mouse.accepted = false; }
                }
            }

            HiFiGlyphs {
                // "Close" button
                visible: window ? window.closable : false
                text: closeClickArea.containsPress ? "x" : "w"
                color: closeClickArea.containsMouse ? hifi.colors.redHighlight : hifi.colors.white
                size: frame.iconSize
                MouseArea {
                    id: closeClickArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: window.visible = false;
                }
            }
        }

        RalewayRegular {
            // Title
            id: titleText
            anchors { left: parent.left; leftMargin: iconSize; right: controlsRow.left;  rightMargin: iconSize; top: parent.top; topMargin: iconSize / 2; }  // DJRTODO
            text: window ? window.title : ""
            color: hifi.colors.white
            size: 16
        }

        DropShadow {
            source: titleText
            anchors.fill: titleText
            horizontalOffset: 1
            verticalOffset: 1
            samples: 2
            color: hifi.colors.baseGrayShadow60
            visible: (window && window.focus)
            cached: true
        }
    }
}

