import QtQuick
import QtQuick.Controls 6.8
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "small_gui_components"
import "app_style"

Page {
    id: formPage
    property int maxInputWidth: 300
    property var usersInProject: new Array(0)
    property int index: 0

    ColorPalette { id: colorPalette }
    FontStyle { id: fontStyle }
    SpacingObjects { id: spacingObjects }

    background: Rectangle {
        color: settings.light_mode ? colorPalette.background100 : colorPalette.background900
    }

    ColumnLayout {
        id: formContainer
        anchors.centerIn: parent
        spacing: spacingObjects.preserveSpacingProportion(spacingObjects.spacing_md, root.width, root.height, true)
        width: Math.min(parent.width / 3, maxInputWidth)  // Set a maximum width for the form
        height: implicitHeight

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "<font color=\""+ (settings.light_mode ? colorPalette.primary600 : colorPalette.primary300) +"\">New project info</font>"
            font.pixelSize: 20
            color: "black"
        }

        MyTextFieldLabel{
            id: projectNameField
            upText: "Project name"
            parentWidth: parent.width - spacingObjects.preserveSpacingProportion(spacingObjects.spacing_x_big, root.width, root.height, false)
        }

        RowLayout{
            Text{
                id: usersText
                text: "Users: "
                font.pixelSize: 16
                height: 40
                Layout.fillWidth: true
                Layout.maximumWidth: maxInputWidth  // Set a maximum width for the input
            }

            MyButton {
                id: addUserButton
                buttonHeight: 50  // Fixed height for the button
                buttonWidth: 100
                Layout.alignment: Qt.AlignBottom
                text: "Add new user"

                onClicked: {
                    index = user.projects.length
                    stackView.push("add_to_project.qml", {
                       currentIndex: index,
                       onReturn: function(returnedUsers) {
                            usersInProject = returnedUsers;
                            console.log("Returned users:", returnedUsers);
                        }
                   });
                }
            }

        }

        // Buttons Row
        RowLayout {
            spacing: spacingObjects.preserveSpacingProportion(spacingObjects.spacing_big, root.width, root.height, false)
            Layout.alignment: Qt.AlignHCenter

            // Accept Button
            Button {
                text: "Accept"
                font.pixelSize: 16
                width: 100
                height: 40
                background: Rectangle {
                    color: "green"
                    radius: 5
                }
                contentItem: Text {
                    text: "Accept"
                    color: "white"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }
                onClicked:{
                    if(projectNameField.text !== ""){
                        user.add_new_project_from_FE(projectNameField.downText, usersInProject);
                        stackView.push("chat_module.qml");
                    }
                }
            }

            // Cancel Button
            Button {
                text: "Cancel"
                font.pixelSize: 16
                width: 100
                height: 40
                background: Rectangle {
                    color: "red"
                    radius: 5
                }
                contentItem: Text {
                    text: "Cancel"
                    color: "white"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }
                onClicked: {
                    stackView.pop();
                }
            }
        }
    }
}
