import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    title: "Simulazione Estuario"

    visibility: Window.Maximized

    property string outputFileName
    property string startDate
    property string simulationDuration
    property string timeStep
    property string timeUnit: "secondi" // Default unit
    property string outputVars

    property string channelDataFile
    property string crossSectionFile
    property string initialCondition
    property string boundaryConditionUpper
    property string boundaryConditionLower
    property string fileDEBC
    property string fileHydro

    property string courantNumber
    property string flowLimiter
    property string flowLimiterEquation
    property string psiFormula
    property string deltaValue
    property string gradientMethod
    property string sourceTerm

    property string salinityCalculation
    property string salinityFile
    property string betaSalinity
    property string longitudinalDispersionKh
    property string sedimentTransport
    property string sedimentTransportEquation
    property string sedimentFile

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: page1
    }

    Component {
        id: page1
        Rectangle {
            color: "#ffffff"
            Column {
                anchors.centerIn: parent
                spacing: 10
                padding: 20
                width: parent.width * 0.9
                Text { text: "Simulazione Estuario"; font.pixelSize: 20; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }

                TextField {
                    id: outputFileName
                    placeholderText: "Nome del file di output"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: startDate
                    placeholderText: "Data e ora di inizio (hh-mm-ss gg/mm/aaaa)"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: simulationDuration
                    placeholderText: "Durata della simulazione (secondi)"
                    width: parent.width * 0.8
                    height: 40
                }

                Row {
                    width: parent.width * 0.8
                    spacing: 10

                    TextField {
                        id: timeStep
                        placeholderText: "Passo temporale"
                        width: parent.width * 0.5
                        height: 40
                    }

                    ComboBox {
                        id: timeUnitCombo
                        width: parent.width * 0.25
                        model: ["secondi", "minuti", "ore"]
                        currentIndex: 0 // Default to "secondi"
                        onCurrentIndexChanged: timeUnit = currentText
                    }
                }

                TextField {
                    id: outputVars
                    placeholderText: "Variabili di output"
                    width: parent.width * 0.8
                    height: 40
                }

                Row {
                    spacing: 20
                    Button {
                        text: "Continua"
                        onClicked: {
                            stackView.push(page2)
                        }
                    }
                    Button {
                        text: "Esci"
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }


    Component {
        id: page2
        Rectangle {
            color: "#e0e0e0"
            Column {
                anchors.centerIn: parent
                spacing: 10
                padding: 20
                width: parent.width * 0.9

                Text { text: "Geometria del Canale"; font.pixelSize: 20; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }

                TextField {
                    id: channelDataFile
                    placeholderText: "Nome del file di dati del canale"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: crossSectionFile
                    placeholderText: "Nome file geometria canale sezioni trasversali"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: initialCondition
                    placeholderText: "Condizione iniziale (0 = calma)"
                    width: parent.width * 0.8
                    height: 40
                }

                Text { text: "Condizione di confine superiore (0 = flusso aperto, 1 = riflettente, 2 = elevazione)" }
                Row {
                    spacing: 10
                    RadioButton { text: "Flusso aperto"; checked: boundaryConditionUpper === "0"; onCheckedChanged: boundaryConditionUpper = "0" }
                    RadioButton { text: "Riflettente"; checked: boundaryConditionUpper === "1"; onCheckedChanged: boundaryConditionUpper = "1" }
                    RadioButton { text: "Elevazione"; checked: boundaryConditionUpper === "2"; onCheckedChanged: boundaryConditionUpper = "2" }
                }

                Text { text: "Condizione di confine inferiore (0 = flusso aperto, 1 = riflettente, 2 = elevazione)" }
                Row {
                    spacing: 10
                    RadioButton { text: "Flusso aperto"; checked: boundaryConditionLower === "0"; onCheckedChanged: boundaryConditionLower = "0" }
                    RadioButton { text: "Riflettente"; checked: boundaryConditionLower === "1"; onCheckedChanged: boundaryConditionLower = "1" }
                    RadioButton { text: "Elevazione"; checked: boundaryConditionLower === "2"; onCheckedChanged: boundaryConditionLower = "2" }
                }

                TextField {
                    id: fileDEBC
                    placeholderText: "Nome file DEBC"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: fileHydro
                    placeholderText: "Nome file idroelettrico"
                    width: parent.width * 0.8
                    height: 40
                }

                Row {
                    spacing: 20
                    Button {
                        text: "Indietro"
                        onClicked: {
                            stackView.pop()
                        }
                    }
                    Button {
                        text: "Continua"
                        onClicked: {
                            stackView.push(page3)
                        }
                    }
                    Button {
                        text: "Esci"
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }

    Component {
        id: page3
        Rectangle {
            color: "#d0d0d0"
            Column {
                anchors.centerIn: parent
                spacing: 10
                padding: 20
                width: parent.width * 0.9
                Text { text: "Costanti e Metodi di Calcolo"; font.pixelSize: 20; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }

                TextField {
                    id: courantNumber
                    placeholderText: "Numero Courant (0 - 1)"
                    width: parent.width * 0.8
                    height: 40
                }

                Text { text: "Limitatore di flusso McComarck (y/n)" }
                Row {
                    spacing: 10
                    RadioButton { text: "Sì"; checked: flowLimiter === "y"; onCheckedChanged: flowLimiter = "y" }
                    RadioButton { text: "No"; checked: flowLimiter === "n"; onCheckedChanged: flowLimiter = "n" }
                }

                Text { text: "Equazione per il flusso limitatore" }
                ComboBox {
                    id: flowLimiterEquation
                    width: parent.width * 0.8
                    height: 40
                    model: ["MinMod", "Roe", "Van Leer", "Van Albada"]
                    onCurrentIndexChanged: flowLimiterEquation = model[currentIndex]
                }

                Text { text: "Formula Psi" }
                ComboBox {
                    id: psiFormulaSelector
                    width: parent.width * 0.8
                    height: 40
                    model: ["1 = Garcia-Navarro", "2 = Tseng"]
                    onCurrentIndexChanged: psiFormula = model[currentIndex].split(" = ")[0]
                }

                TextField {
                    id: psiFormulaDisplay
                    text: "Formula Psi selezionata: " + psiFormula
                    width: parent.width * 0.8
                    height: 40
                    readOnly: true
                }

                TextField {
                    id: deltaValue
                    placeholderText: "Valore delta"
                    width: parent.width * 0.8
                    height: 40
                }

                Text { text: "Metodo del gradiente di superficie (y/n)" }
                Row {
                    spacing: 10
                    RadioButton { text: "Sì"; checked: gradientMethod === "y"; onCheckedChanged: gradientMethod = "y" }
                    RadioButton { text: "No"; checked: gradientMethod === "n"; onCheckedChanged: gradientMethod = "n" }
                }

                Text { text: "Termine sorgente saldo (y/n)" }
                Row {
                    spacing: 10
                    RadioButton { text: "Sì"; checked: sourceTerm === "y"; onCheckedChanged: sourceTerm = "y" }
                    RadioButton { text: "No"; checked: sourceTerm === "n"; onCheckedChanged: sourceTerm = "n" }
                }

                TextField {
                    id: salinityFile
                    placeholderText: "Nome file salinità"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: betaSalinity
                    placeholderText: "Costante beta per la salinità"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: longitudinalDispersionKh
                    placeholderText: "Costante di dispersione longitudinale, Kh"
                    width: parent.width * 0.8
                    height: 40
                }

                Text { text: "Calcolare il trasporto dei sedimenti (y/n)" }
                Row {
                    spacing: 10
                    RadioButton { text: "Sì"; checked: sedimentTransport === "y"; onCheckedChanged: sedimentTransport = "y" }
                    RadioButton { text: "No"; checked: sedimentTransport === "n"; onCheckedChanged: sedimentTransport = "n" }
                }

                TextField {
                    id: sedimentTransportEquation
                    placeholderText: "Equazione per il trasporto solido"
                    width: parent.width * 0.8
                    height: 40
                }

                TextField {
                    id: sedimentFile
                    placeholderText: "Nome file proprietà sedimenti"
                    width: parent.width * 0.8
                    height: 40
                }

                Row {
                    spacing: 20
                    Button {
                        text: "Indietro"
                        onClicked: {
                            stackView.pop()
                        }
                    }
                    Button {
                        text: "Avvia Simulazione"
                        onClicked: {
                            avviaSimulazione()
                        }
                    }
                    Button {
                        text: "Esci"
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }

    Component {
        id: page4
        Rectangle {
            color: "#f0f0f0"
            Column {
                anchors.centerIn: parent
                spacing: 10
                padding: 20
                width: parent.width * 0.9
                Text { text: "Risultati della Simulazione"; font.pixelSize: 20; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }

                TextArea {
                    id: page4Result
                    text: ""
                    width: parent.width * 0.8
                    height: parent.height * 0.6
                    readOnly: true
                }

                Row {
                    spacing: 20
                    Button {
                        text: "Indietro"
                        onClicked: {
                            stackView.pop()
                        }
                    }
                    Button {
                        text: "Esci"
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }

    function avviaSimulazione() {
        var durata = parseInt(simulationDuration.text);
        var passoTemporale = parseInt(timeStep.text);

        // Converti il passo temporale in secondi in base all'unità selezionata
        if (timeUnit === "minuti") {
            passoTemporale *= 60;
        } else if (timeUnit === "ore") {
            passoTemporale *= 3600;
        }

        var courant = parseFloat(courantNumber.text);

        var numPassi = durata / passoTemporale;
        var velocitaFlusso = courant * numPassi;

        var salinità = 0;
        if (salinityCalculation === "y") {
            var beta = parseFloat(betaSalinity.text);
            var kh = parseFloat(longitudinalDispersionKh.text);
            salinità = beta * kh * numPassi;
        }

        var trasportoSedimenti = 0;
        if (sedimentTransport === "y") {
            trasportoSedimenti = parseFloat(sedimentTransportEquation.text) * numPassi;
        }

        page4Result.text = "Numero di passi: " + numPassi + "\nVelocità del flusso: " + velocitaFlusso.toFixed(2) + " m/s" +
                           "\nSalinità: " + salinità.toFixed(2) + " g/L" +
                           "\nTrasporto Sedimenti: " + trasportoSedimenti.toFixed(2) + " kg/s" +
                           "\n\nDettagli:\n" +
                           "Nome del file di output: " + outputFileName.text + "\n" +
                           "Data di inizio: " + startDate.text + "\n" +
                           "Durata della simulazione: " + simulationDuration.text + " secondi\n" +
                           "Passo temporale: " + timeStep.text + " " + timeUnit + "\n" +
                           "Variabili di output: " + outputVars.text + "\n" +
                           "File dati canale: " + channelDataFile.text + "\n" +
                           "Condizione iniziale: " + initialCondition.text + "\n" +
                           "Condizione di confine superiore: " + boundaryConditionUpper + "\n" +
                           "Condizione di confine inferiore: " + boundaryConditionLower;

        stackView.push(page4);
    }
    function salvaRisultati() {
        var fileDialog = Qt.createQmlObject('import QtQuick.Dialogs; FileDialog {}', parent);
        fileDialog.fileMode = FileDialog.SaveFile;
        fileDialog.nameFilters = ["File di testo (*.txt)"];
        fileDialog.defaultSuffix = "txt";
        fileDialog.title = "Salva risultati della simulazione";
        fileDialog.accepted.connect(function() {
            var filePath = fileDialog.selectedFile;
            console.log("Percorso del file selezionato: " + filePath);

            var request = new XMLHttpRequest();
            request.open("PUT", filePath.toString(), false);
        });
        fileDialog.open();
    }
}
