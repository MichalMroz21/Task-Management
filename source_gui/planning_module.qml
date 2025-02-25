import QtQuick
import QtQuick.Controls 2.0
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "gui_components"
import "small_gui_components"

Page {
    property var usersInProject: new Array(0)

    id: projectPage

    background: Rectangle {
        color: settings.light_mode ? colorPalette.background100 : colorPalette.background900
    }

    GridLayout {
        columns: 1  // Make sure it's only one column to resemble ColumnLayout
        rows: 2

        anchors.centerIn: parent
        width: parent.width * 2 / 3
        height: parent.height * 2 / 3
        rowSpacing: spacingObjects.preserveSpacingProportion(spacingObjects.spacing_big, root.width, root.height, true)

        ProjectList {
            id: projectList
            list_width: parent.width * 2 / 3
            list_fill_width: false
            Layout.alignment: Qt.AlignHCenter

            userClicked: function(model, name, usersNumber, totalTasksNumber, inProgressTasksNumber, mouseArea, popup) {
                console.log(model.index);
                stackView.push("project_details.qml", {currentIndex: model.index});
            }
        }

        MyButton {
            id: addUserButton
            Layout.alignment: Qt.AlignHCenter
            buttonText: "New Project"

            onClickedFunction: function () {
                stackView.push("add_project.qml");
            }
        }
    }
}
