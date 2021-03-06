// [WriteFile Name=DensifyAndGeneralize, Category=Geometry]
// [Legal]
// Copyright 2018 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

import QtQuick 2.6
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import Esri.Samples 1.0

DensifyAndGeneralizeSample {
    id: rootRectangle
    clip: true
    width: 800
    height: 600

    property real scaleFactor: (Screen.logicalPixelDensity * 25.4) / (Qt.platform.os === "windows" ? 96 : 72)

    // add a mapView component
    MapView {
        anchors.fill: parent
        objectName: "mapView"
    }

    Rectangle {
        anchors {
            fill: controlColumn
            margins: -5 * scaleFactor
        }
        color: "#f9f9f9"
        radius: 5 * scaleFactor
    }

    Column {
        id: controlColumn
        anchors {
            left: parent.left
            top: parent.top
            margins: 10 * scaleFactor
        }
        spacing: 5 * scaleFactor


        CheckBox {
            id: densifyCheckbox
            text: "Densify"
            checked: true
        }

        Text {
            text: "Max segment length"
            enabled: densifyCheckbox.checked
        }

        Slider {
            id: maxSegmentLengthSlider
            minimumValue: 100
            maximumValue: 500
            width: 175 * scaleFactor
            value: 100
            onValueChanged: updateGeometry(densifyCheckbox.checked, maxSegmentLengthSlider.value, generalizeCheckbox.checked, maxDeviationSlider.value);
        }

        CheckBox {
            id: generalizeCheckbox
            text: "Generalize"
            checked: true
        }

        Text {
            text: "Max deviation"
            enabled: generalizeCheckbox.checked
        }

        Slider {
            id: maxDeviationSlider
            minimumValue: 1
            maximumValue: 250
            width: 175 * scaleFactor
            onValueChanged: updateGeometry(densifyCheckbox.checked, maxSegmentLengthSlider.value, generalizeCheckbox.checked, maxDeviationSlider.value);
        }

        CheckBox {
            id: showResultCheckbox
            text: "Show Result"
            checked: true
            onCheckedChanged: showResults(checked);
        }
    }
}
