import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

import "../app_style"

Item {
    id: textField

    ColorPalette { id: colorPalette }
    FontStyle { id: fontStyle }

    property string upText: ""

    property alias downText: downTextField.text
    property string placeholder : ""
    property alias placeholderColor: downTextField.placeholderTextColor

    property color textFieldColor: "transparent"
    property color borderColor: settings.light_mode ? colorPalette.primary600 : colorPalette.primary300
    property color textColor: settings.light_mode ? colorPalette.primary600 : colorPalette.primary300
    property alias upTextFontSize: upTextVar.font.pixelSize
    property alias downTextFontSize: downTextField.font.pixelSize
    property alias downTextFieldHeight: downTextField.implicitHeight

    property bool runOnClick: false
    property var customFunctionClick

    signal accepted()

    property bool enablePlaceholderWhenTyping: false
    property bool visibleUpText: true

    property bool isEditable: true

    property int borderWidth: 1
    property int parentWidth
    property int parentHeight

    property alias fontSize: upTextVar.font.pixelSize

    property int implicitWidthProp: parentWidth
    property int maxLengthText: 50

    property bool textOnly: false
    property bool richTextProp: false

    implicitWidth: implicitWidthProp
    implicitHeight: upTextVar.height + downTextField.height

    ColumnLayout {
        id: layout
        implicitWidth: textField.implicitWidth

        Text {
            id: upTextVar
            text: textField.upText
            color: settings.light_mode ? colorPalette.primary600 : colorPalette.primary300
            visible: textField.visibleUpText

            textFormat: richTextProp ? Text.RichText : Text.PlainText

            font.pixelSize: fontStyle.getFontSize(fontStyle.paragraph_large, root.width, root.height)

            MouseArea {
                id: textFieldMouseAreaText
                enabled: textOnly

                anchors.fill: parent

                onClicked: {
                    if (textField.runOnClick) {
                        textField.customFunctionClick();
                    }
                }
            }
        }

        TextField {
            id: downTextField
            color: textField.textColor
            implicitWidth: parent.width
            visible: !textOnly
            //implicitHeight: tu zmiana wysokosci textfielda

            readOnly: !isEditable
            maximumLength: textField.maxLengthText

            font.pixelSize: fontStyle.getFontSize(fontStyle.paragraph_large, root.width, root.height)

            background: Rectangle {
                color: textField.textFieldColor
                radius: spacingObjects.preserveSpacingProportion(spacingObjects.spacing_xxx_sm, root.width, root.height, false)
                width: parent.width

                border.color: textField.borderColor
                border.width: textField.borderWidth
            }

            placeholderText: focus || downText ? "" : placeholder

            focus: downTextField.focus

            MouseArea {
                id: textFieldMouseArea
                enabled: runOnClick

                anchors.fill: parent

                onClicked: {
                    if (textField.runOnClick) {
                        textField.customFunctionClick();
                    }
                }
            }

            onAccepted: {
                textField.accepted();
            }
        }
    }
}
