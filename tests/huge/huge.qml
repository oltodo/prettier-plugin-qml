import QtQuick 2.9
import QtQuick.Controls 2.3
import QtCharts 2.2
import QtQml.Models 2.3
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    id: item
    BusyIndicator {
        id: ind
        anchors.centerIn: parent
        width: parent.width/5
        height: parent.height/5
        running: true
    }

    Loader {
        id: load
        anchors.fill: parent
        sourceComponent: comp
        asynchronous: true
        visible: status == Loader.Ready
        onLoaded: {
            ind.running = false
        }
    }


Component {
    id: comp


    Page {
        id: page
        property int yy: 0
        Component.onCompleted: {
            qmlGetDate()
            qmlGetTipMeh()
            qmlGetPersonal()
            qmlKolAgr()
        }
        anchors.fill: parent
        Rectangle {
            id: rec1
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height*4/5
            Rectangle {
                id: rec_filter
                objectName: "filter_izmer"
                visible: false
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 50
                property string date_begin
                property string date_end
                property int razmer
                property var personal: []
                property string personal_select: ""
                property int razmer_tipmeh
                property var tipmeh: []
                property string tipmeh_select: ""
                property bool tipmeh_visible: true
                Text {
                    id: text_date_begin
                    visible: rec_filter.visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.pixelSize: 15
                    text: "Дата c:"
                }
                TextField {
                    id: tf_date_begin
                    visible: rec_filter.visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.left: text_date_begin.right
                    anchors.leftMargin: 5
                    width: 90
                    focus: true
                    selectByMouse: true
                    persistentSelection: true
                    inputMask: "00-00-0000"
                    inputMethodHints: Qt.ImhDate
                    horizontalAlignment: TextInput.AlignHCenter
                    text: Qt.formatDateTime(rec_filter.date_begin, "ddMMyyyy")
                    Keys.onPressed: {
                        if(event.key === Qt.Key_Enter){
                            rec_filter.date_begin = tf_date_begin.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            rec_filter.date_end = tf_date_end.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            qmlGetDate2()
                                                qmlKolAgr()
                            chartIzmerMes.series_add()
                            chartIzmerMes1.series_add()
                            chartIzmerDay.series_add()
                            chartIzmerDay1.series_add()
                            chartIzmerTime.series_add()
                            chartIzmerTime1.series_add()
                            chartIzmerPersonal.series_add()
                            chartIzmerPersonal1.series_add()                            
                                            }
                        if(event.key === Qt.Key_Return){
                            rec_filter.date_begin = tf_date_begin.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            rec_filter.date_end = tf_date_end.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            qmlGetDate2()
                                                qmlKolAgr()
                            chartIzmerMes.series_add()
                            chartIzmerMes1.series_add()
                            chartIzmerDay.series_add()
                            chartIzmerDay1.series_add()
                            chartIzmerTime.series_add()
                            chartIzmerTime1.series_add()
                            chartIzmerPersonal.series_add()
                            chartIzmerPersonal1.series_add()
                                            }
                    }
                    MouseArea {
                        acceptedButtons: Qt.RightButton
                        anchors.fill: parent
                        onClicked: {
                            contextMenu_date_begin.x = mouseX
                            contextMenu_date_begin.y = mouseY
                            contextMenu_date_begin.open()
                        }
                    }
                    Menu {
                        id: contextMenu_date_begin
                        MenuItem {
                            text: qsTr("Копировать")
                            enabled: tf_date_begin.selectedText
                            onTriggered: tf_date_begin.copy()
                        }
                        MenuItem {
                            text: qsTr("Вырезать")
                            enabled: tf_date_begin.selectedText
                            onTriggered: tf_date_begin.cut()
                        }
                        MenuItem {
                            text: qsTr("Вставить")
                            enabled: tf_date_begin.canPaste
                            onTriggered: tf_date_begin.paste()
                        }
                    }
                }
                Text {
                    id: text_date_end
                    visible: rec_filter.visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.left: tf_date_begin.right
                    anchors.leftMargin: 5
                    font.pixelSize: 15
                    text: "по:"
                }
                TextField {
                    id: tf_date_end
                    visible: rec_filter.visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.left: text_date_end.right
                    anchors.leftMargin: 5
                    width: 90
                    focus: true
                    selectByMouse: true
                    persistentSelection: true
                    inputMask: "00-00-0000"
                    inputMethodHints: Qt.ImhDate
                    horizontalAlignment: TextInput.AlignHCenter
                    text: Qt.formatDateTime(rec_filter.date_end, "ddMMyyyy")
                    Keys.onPressed: {
                        if(event.key === Qt.Key_Enter){
                            rec_filter.date_begin = tf_date_begin.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            rec_filter.date_end = tf_date_end.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            qmlGetDate2()
                                                qmlKolAgr()
                            chartIzmerMes.series_add()
                            chartIzmerMes1.series_add()
                            chartIzmerDay.series_add()
                            chartIzmerDay1.series_add()
                            chartIzmerTime.series_add()
                            chartIzmerTime1.series_add()
                            chartIzmerPersonal.series_add()
                            chartIzmerPersonal1.series_add()
                                            }
                        if(event.key === Qt.Key_Return){
                            rec_filter.date_begin = tf_date_begin.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            rec_filter.date_end = tf_date_end.text.replace(/(\d+)-(\d+)-(\d+)/,'$3-$2-$1') + " 00:00:00.000"
                            qmlGetDate2()
                                                qmlKolAgr()
                            chartIzmerMes.series_add()
                            chartIzmerMes1.series_add()
                            chartIzmerDay.series_add()
                            chartIzmerDay1.series_add()
                            chartIzmerTime.series_add()
                            chartIzmerTime1.series_add()
                            chartIzmerPersonal.series_add()
                            chartIzmerPersonal1.series_add()
                                            }
                    }
                    MouseArea {
                        acceptedButtons: Qt.RightButton
                        anchors.fill: parent
                        onClicked: {
                            contextMenu_date_end.x = mouseX
                            contextMenu_date_end.y = mouseY
                            contextMenu_date_end.open()
                        }
                    }
                    Menu {
                        id: contextMenu_date_end
                        MenuItem {
                            text: qsTr("Копировать")
                            enabled: tf_date_end.selectedText
                            onTriggered: tf_date_end.copy()
                        }
                        MenuItem {
                            text: qsTr("Вырезать")
                            enabled: tf_date_end.selectedText
                            onTriggered: tf_date_end.cut()
                        }
                        MenuItem {
                            text: qsTr("Вставить")
                            enabled: tf_date_end.canPaste
                            onTriggered: tf_date_end.paste()
                        }
                    }
                }
                Text {
                    id: text_personal
                    visible: rec_filter.visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.right: combo_personal.left
                    anchors.rightMargin: 5
                    font.pixelSize: 15
                    text: "Персонал:"
                }
                ComboBox {
                    id: combo_personal
                    visible: rec_filter.visible
                    currentIndex: -1
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.right: but_personal.left
                    anchors.rightMargin: 5
                    width: 200
                    model: ListModel{
                        id: model_personal
                    }
                    Component.onCompleted: {
                        for(var i=0;i<rec_filter.razmer;i++){
                            model_personal.append({text: rec_filter.personal[i]})
                        }
                    }
                    onCurrentTextChanged: {
                        rec_filter.personal_select = combo_personal.currentText
                        qmlGetDate2()
                                            qmlKolAgr()
                        chartIzmerMes.series_add()
                        chartIzmerMes1.series_add()
                        chartIzmerDay.series_add()
                        chartIzmerDay1.series_add()
                        chartIzmerTime.series_add()
                        chartIzmerTime1.series_add()
                    }
                }
                Button {
                    id: but_personal
                    visible: rec_filter.visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    width: height
                    highlighted: true
                    Material.accent: Material.LightBlue
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 20
                        //color: "white"
                        text: "X"
                    }
                    onClicked: {
                        combo_personal.currentIndex = -1
                        rec_filter.personal_select = combo_personal.currentText
                        qmlGetDate2()
                                            qmlKolAgr()
                        chartIzmerMes.series_add()
                        chartIzmerMes1.series_add()
                        chartIzmerDay.series_add()
                        chartIzmerDay1.series_add()
                        chartIzmerTime.series_add()
                        chartIzmerTime1.series_add()
                    }
                }
                Text {
                    id: text_tipmeh
                    visible: rec_filter.tipmeh_visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.right: combo_tipmeh.left
                    anchors.rightMargin: 5
                    font.pixelSize: 15
                    text: "Тип агрегата:"
                }
                ComboBox {
                    id: combo_tipmeh
                    visible: rec_filter.tipmeh_visible
                    currentIndex: -1
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.right: but_tipmeh.left
                    anchors.rightMargin: 5
                    width: 200
                    model: ListModel{
                        id: model_tipmeh_combo
                    }
                    Component.onCompleted: {
                        for(var i=0;i<rec_filter.razmer_tipmeh;i++){
                            model_tipmeh_combo.append({text: rec_filter.tipmeh[i]})
                        }
                    }
                    onCurrentTextChanged: {
                        rec_filter.tipmeh_select = combo_tipmeh.currentText
                        qmlGetDate2()
                                            qmlKolAgr()
                        chartIzmerAgr.series_add()
                        chartIzmerAgr1.series_add()
                    }
                }
                Button {
                    id: but_tipmeh
                    visible: rec_filter.tipmeh_visible
                    anchors.verticalCenter: rec_filter.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    width: height
                    highlighted: true
                    Material.accent: Material.LightBlue
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 20
                        //color: "white"
                        text: "X"
                    }
                    onClicked: {
                        combo_tipmeh.currentIndex = -1
                        rec_filter.tipmeh_select = combo_tipmeh.currentText
                        qmlGetDate2()
                                            qmlKolAgr()
                        chartIzmerAgr.series_add()
                        chartIzmerAgr1.series_add()
                    }
                }
            }//end rec_filter

            ChartView {
                id: chartKolAgr
                objectName: "chartKolAgr"
                property var array_nameagr
                property var array_kolagr
                property int razmer
                visible: true
                anchors.fill: parent
                antialiasing: true
                legend.visible: false
                title: "Количество агрегатов"
                BarSeries {
                    id: pie_series
                    labelsVisible: true
                    labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                    axisY: ValueAxis {
                        id: yAxis
                                min: 0
                                max: 10
                                labelsVisible: false
                    }
                    axisX: BarCategoryAxis { categories: chartKolAgr.array_nameagr }
                }
                Component.onCompleted: {
                    //qmlKolAgr()
                    var kol = []
                    for(var i=0;i<razmer;i++){
                        kol[i] = parseInt(array_kolagr[i], 10)
                    }
                    yAxis.max = Math.max.apply(null, kol)*1.1+1
                    var bar = pie_series.append("label", kol)
                    bar.labelColor = "black"
                }
            }
            ChartView {
                id: chartIzmerMes
                objectName: "chartIzmerMes"
                property var array_namemes
                property var array_kolmes
                property int razmer
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
                legend.visible: false
                title: "Количество измерений по месяцам"
                BarSeries {
                    id: pie_seriesMes
                    labelsVisible: true
                    labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                    axisY: ValueAxis {
                        id: yAxisMes
                                min: 0
                                max: 10
                                labelsVisible: false
                    }
                    axisX: BarCategoryAxis { categories: chartIzmerMes.array_namemes
                    labelsAngle: -90}
                }
                Component.onCompleted: {
                    var kol = []
                    for(var i=0;i<razmer;i++){
                        kol[i] = parseInt(array_kolmes[i], 10)
                    }
                    yAxisMes.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesMes.append("label", kol)
                    bar.labelColor = "black"
                }
                function series_add(){
                    pie_seriesMes.clear()
                    chartIzmerMes.update()
                    var kol = []
                    for(var i=0;i<razmer;i++){
                        kol[i] = parseInt(array_kolmes[i], 10)
                    }
                    yAxisMes.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesMes.append("label", kol)
                    bar.labelColor = "black"
                }
            }
            ChartView {
                id: chartIzmerDay
                objectName: "chartIzmerDay"
                property var array_nameday
                property var nameday: [7]
                property var array_kolday
                property var kolday: [7]
                property int razmer
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
                legend.visible: false
                title: "Количество измерений по дням недели"
                BarSeries {
                    id: pie_seriesDay
                    labelsVisible: true
                    labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                    axisY: ValueAxis {
                        id: yAxisDay
                                min: 0
                                max: 10
                                labelsVisible: false
                    }
                    axisX: BarCategoryAxis {id: category
                        categories: chartIzmerDay.nameday
                    //labelsAngle: -90
                    }
                }
                Component.onCompleted: {
                    nameday[0] = array_nameday[1]
                    nameday[1] = array_nameday[2]
                    nameday[2] = array_nameday[3]
                    nameday[3] = array_nameday[4]
                    nameday[4] = array_nameday[5]
                    nameday[5] = array_nameday[6]
                    nameday[6] = array_nameday[0]
                    kolday[0] = array_kolday[1]
                    kolday[1] = array_kolday[2]
                    kolday[2] = array_kolday[3]
                    kolday[3] = array_kolday[4]
                    kolday[4] = array_kolday[5]
                    kolday[5] = array_kolday[6]
                    kolday[6] = array_kolday[0]
                    var kol = []
                    for(var i=0;i<razmer;i++){
                        kol[i] = parseInt(kolday[i], 10)
                    }
                    yAxisDay.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesDay.append("label", kol)
                    category.categories = nameday
                    bar.labelColor = "black"
                }
                function series_add(){
                    pie_seriesDay.clear()
                    chartIzmerDay.update()
                    kolday = [0,0,0,0,0,0,0]
                    for(var i=0;i<7;i++){
                        if(array_nameday[i] === "Пн"){
                            kolday[0] = array_kolday[i]
                        }
                        if(array_nameday[i] === "Вт"){
                            kolday[1] = array_kolday[i]
                        }
                            if(array_nameday[i] === "Ср"){
                                kolday[2] = array_kolday[i]
                            }
                                if(array_nameday[i] === "Чт"){
                                    kolday[3] = array_kolday[i]
                                }
                                    if(array_nameday[i] === "Пт"){
                                        kolday[4] = array_kolday[i]
                                    }
                                        if(array_nameday[i] === "Сб"){
                                            kolday[5] = array_kolday[i]
                                        }
                                            if(array_nameday[i] === "Вс"){
                                                kolday[6] = array_kolday[i]
                                            }
                    }
                    var kol = []
                    for(var i=0;i<7;i++){
                        kol[i] = parseInt(kolday[i], 10)
                    }
                    yAxisDay.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesDay.append("label", kol)
                    bar.labelColor = "black"
                }
            }
            ChartView {
                id: chartIzmerTime
                objectName: "chartIzmerTime"
                property var array_koltime
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
                legend.visible: false
                title: "Количество измерений по часам"
                BarSeries {
                    id: pie_seriesTime
                    labelsVisible: true
                    labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                    axisY: ValueAxis {
                        id: yAxisTime
                                min: 0
                                max: 10
                                labelsVisible: false
                    }
                    axisX: BarCategoryAxis {id: category2
                        categories: ["00-01","01-02","02-03","03-04","04-05","05-06","06-07","07-08","08-09","09-10","10-11","11-12",
                            "12-13","13-14","14-15","15-16","16-17","17-18","18-19","19-20","20-21","21-22","22-23","23-24"]
                    labelsAngle: -90
                    //labelsVisible: false
                    }
                }
                Component.onCompleted: {
                    var kol = []
                    for(var i=0;i<24;i++){
                        kol[i] = parseInt(array_koltime[i], 10)
                    }
                    yAxisTime.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesTime.append("label", kol)
                    bar.labelColor = "black"
                }
                function series_add(){
                    pie_seriesTime.clear()
                    chartIzmerTime.update()
                    var kol = []
                    for(var i=0;i<24;i++){
                        kol[i] = parseInt(array_koltime[i], 10)
                    }
                    console.log("koltime = ", kol)
                    yAxisTime.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesTime.append("label", kol)
                    bar.labelColor = "black"
                }
            }
            ChartView {
                id: chartIzmerPersonal
                objectName: "chartIzmerPersonal"
                property var array_kolpersonal
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
                legend.visible: false
                title: "Количество измерений персоналом"
                BarSeries {
                    id: pie_seriesPersonal
                    labelsVisible: true
                    labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                    axisY: ValueAxis {
                        id: yAxisPersonal
                                min: 0
                                max: 10
                                labelsVisible: false
                    }
                    axisX: BarCategoryAxis {id: categorypersonal
                        categories: rec_filter.personal
                    }
                }
                Component.onCompleted: {
                    var kol = []
                    for(var i=0;i<rec_filter.razmer;i++){
                        kol[i] = parseInt(array_kolpersonal[i], 10)
                    }
                    yAxisPersonal.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesPersonal.append("label", kol)
                    bar.labelColor = "black"
                }
                function series_add(){
                    pie_seriesPersonal.clear()
                    chartIzmerPersonal.update()
                    var kol = []
                    for(var i=0;i<rec_filter.razmer;i++){
                        kol[i] = parseInt(array_kolpersonal[i], 10)
                    }
                    console.log("koltime = ", kol)
                    yAxisPersonal.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                    var bar = pie_seriesPersonal.append("label", kol)
                    bar.labelColor = "black"
                }
            }
            ChartView {
                id: chartIzmerHh
                objectName: "chartIzmerHh"
                property int count
                property var array_dateX
                property var array_valueY
                property var array_valueY1
                property var array_valueY2
                property real oldX1
                property real oldY1
                property real oldX2
                property real oldY2
                property real oldX
                property real oldY
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
                legend.visible: true
                title: "Средняя вибрация на холостом ходу"
                ValueAxis {
                    id: axiY
                    min: 0
                }
                DateTimeAxis {
                    id: axiX
                    format: "dd-MM-yyyy"
                    min: rec_filter.date_begin
                    max: rec_filter.date_end
                }
                LineSeries {
                    id: line1
                    property string date_x
                    property string value_y
                    property bool state: false
                    name: "Среднее значение нормы"
                    color: "lightgreen"
                    axisY: axiY
                    axisX: axiX
                    width: 5
                    onClicked: {
                            state = true
                    }
                    onHovered: {
                        var d = new Date(point.x),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();
                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;
                        date_x = ([day, month, year].join('-')).toString()
                        value_y = ((point.y).toFixed(2)).toString()
                        scatter1.replace(chartIzmerHh.oldX1, chartIzmerHh.oldY1, point.x, point.y)
                        chartIzmerHh.oldX1 = point.x
                        chartIzmerHh.oldY1 = point.y
                    }
                }
                ScatterSeries {
                    id: scatter1
                    visible: line1.state
                    pointLabelsVisible: true
                    pointLabelsClipping: false
                    //pointLabelsFont: bold
                    pointLabelsFormat: "" + line1.value_y +" ; "+ line1.date_x + ""
                    color: "lightgreen"
                    borderColor: "black"
                    axisY: axiY
                    axisX: axiX
                    onClicked: line1.state = false
                }
                LineSeries {
                    id: line2
                    name: "Среднее значение первых пусков"
                    property string date_x
                    property string value_y
                    property bool state: false
                    color: "tomato"
                    axisY: axiY
                    axisX: axiX
                    width: 5
                    onClicked: {
                            state = true
                    }
                    onHovered: {
                        var d = new Date(point.x),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();
                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;
                        date_x = ([day, month, year].join('-')).toString()
                        value_y = ((point.y).toFixed(2)).toString()
                        scatter2.replace(chartIzmerHh.oldX2, chartIzmerHh.oldY2, point.x, point.y)
                        chartIzmerHh.oldX2 = point.x
                        chartIzmerHh.oldY2 = point.y
                    }
                }
                ScatterSeries {
                    id: scatter2
                    visible: line2.state
                    pointLabelsVisible: true
                    pointLabelsClipping: false
                    //pointLabelsFont: bold
                    pointLabelsFormat: "" + line2.value_y +" ; "+ line2.date_x + ""
                    color: "tomato"
                    borderColor: "black"
                    axisY: axiY
                    axisX: axiX
                    onClicked: line2.state = false
                }
                LineSeries {
                    id: line
                    name: "Среднее значение на дату"
                    property string date_x
                    property string value_y
                    property bool state: false
                    color: "#03a9f5"
                    axisY: axiY
                    axisX: axiX
                    width: 5
                    onClicked: {
                            state = true
                    }
                    onHovered: {
                        var d = new Date(point.x),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();
                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;
                        date_x = ([day, month, year].join('-')).toString()
                        value_y = ((point.y).toFixed(2)).toString()
                        scatter.replace(chartIzmerHh.oldX, chartIzmerHh.oldY, point.x, point.y)
                        chartIzmerHh.oldX = point.x
                        chartIzmerHh.oldY = point.y
                    }
                }
                ScatterSeries {
                    id: scatter
                    visible: line.state
                    pointLabelsVisible: true
                    pointLabelsClipping: false
                    //pointLabelsFont: bold
                    pointLabelsFormat: "" + line.value_y +" ; "+ line.date_x + ""
                    color: "#03a9f5"
                    borderColor: "black"
                    axisY: axiY
                    axisX: axiX
                    onClicked: line.state = false
                }
                Component.onCompleted: {
                    var xx = []
                    var yy = []
                    var yy1 = []
                    var yy2 = []
                    var max = 0
                    for(var i=0;i<count;i++){
                        xx[i] = Date.parse(array_dateX[i])
                        yy[i] = Number(array_valueY[i])
                        yy1[i] = Number(array_valueY1[i])
                        yy2[i] = Number(array_valueY2[i])
                        if(yy[i]>max){
                            max = yy[i]
                        }
                        if(yy1[i]>max){
                            max = yy1[i]
                        }
                        if(yy2[i]>max){
                            max = yy2[i]
                        }
                        line.append(xx[i], yy[i])
                        line1.append(xx[i], yy1[i])
                        line2.append(xx[i], yy2[i])                        
                    }
                    oldX1 = xx[count-1]
                    oldY1 = yy1[count-1]
                    oldX2 = xx[count-1]
                    oldY2 = yy2[count-1]
                    oldX = xx[count-1]
                    oldY = yy[count-1]
                    scatter1.append(xx[count-1], yy1[count-1])
                    scatter2.append(xx[count-1], yy2[count-1])
                    scatter.append(xx[count-1], yy[count-1])
                    max = Math.round(max) + 1
                    axiY.max = max
                    //console.log(oldX,oldY)
                }
            }
            ChartView {
                id: chartIzmerAgr
                objectName: "chartIzmerAgr"
                property int count
                property var array_dateX
                property var array_valueY
                property var array_valueY1
                property var array_valueY2
                property real oldX1
                property real oldY1
                property real oldX2
                property real oldY2
                property real oldX
                property real oldY
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                antialiasing: true
                legend.visible: true
                title: "Средняя вибрация агрегатов"
                ValueAxis {
                    id: axiYagr
                    min: 0
                }
                DateTimeAxis {
                    id: axiXagr
                    format: "dd-MM-yyyy"
                    min: rec_filter.date_begin
                    max: rec_filter.date_end
                }
                LineSeries {
                    id: line1agr
                    property string date_x
                    property string value_y
                    property bool state: false
                    name: "Среднее значение нормы"
                    color: "lightgreen"
                    axisY: axiYagr
                    axisX: axiXagr
                    width: 5
                    onClicked: {
                            state = true
                    }
                    onHovered: {
                        var d = new Date(point.x),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();
                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;
                        date_x = ([day, month, year].join('-')).toString()
                        value_y = ((point.y).toFixed(2)).toString()
                        scatter1agr.replace(chartIzmerAgr.oldX1, chartIzmerAgr.oldY1, point.x, point.y)
                        chartIzmerAgr.oldX1 = point.x
                        chartIzmerAgr.oldY1 = point.y
                    }
                }
                ScatterSeries {
                    id: scatter1agr
                    visible: line1agr.state
                    pointLabelsVisible: true
                    pointLabelsClipping: false
                    //pointLabelsFont: bold
                    pointLabelsFormat: "" + line1agr.value_y +" ; "+ line1agr.date_x + ""
                    color: "lightgreen"
                    borderColor: "black"
                    axisY: axiYagr
                    axisX: axiXagr
                    onClicked: line1agr.state = false
                }
                LineSeries {
                    id: line2agr
                    name: "Среднее значение первых пусков"
                    property string date_x
                    property string value_y
                    property bool state: false
                    color: "tomato"
                    axisY: axiYagr
                    axisX: axiXagr
                    width: 5
                    onClicked: {
                            state = true
                    }
                    onHovered: {
                        var d = new Date(point.x),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();
                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;
                        date_x = ([day, month, year].join('-')).toString()
                        value_y = ((point.y).toFixed(2)).toString()
                        scatter2agr.replace(chartIzmerAgr.oldX2, chartIzmerAgr.oldY2, point.x, point.y)
                        chartIzmerAgr.oldX2 = point.x
                        chartIzmerAgr.oldY2 = point.y
                    }
                }
                ScatterSeries {
                    id: scatter2agr
                    visible: line2agr.state
                    pointLabelsVisible: true
                    pointLabelsClipping: false
                    //pointLabelsFont: bold
                    pointLabelsFormat: "" + line2agr.value_y +" ; "+ line2agr.date_x + ""
                    color: "tomato"
                    borderColor: "black"
                    axisY: axiYagr
                    axisX: axiXagr
                    onClicked: line2agr.state = false
                }
                LineSeries {
                    id: lineagr
                    name: "Среднее значение на дату"
                    property string date_x
                    property string value_y
                    property bool state: false
                    color: "#03a9f5"
                    axisY: axiYagr
                    axisX: axiXagr
                    width: 5
                    onClicked: {
                            state = true
                    }
                    onHovered: {
                        var d = new Date(point.x),
                        month = '' + (d.getMonth() + 1),
                        day = '' + d.getDate(),
                        year = d.getFullYear();
                        if (month.length < 2) month = '0' + month;
                        if (day.length < 2) day = '0' + day;
                        date_x = ([day, month, year].join('-')).toString()
                        value_y = ((point.y).toFixed(2)).toString()
                        scatteragr.replace(chartIzmerAgr.oldX, chartIzmerAgr.oldY, point.x, point.y)
                        chartIzmerAgr.oldX = point.x
                        chartIzmerAgr.oldY = point.y
                    }
                }
                ScatterSeries {
                    id: scatteragr
                    visible: lineagr.state
                    pointLabelsVisible: true
                    pointLabelsClipping: false
                    //pointLabelsFont: bold
                    pointLabelsFormat: "" + lineagr.value_y +" ; "+ lineagr.date_x + ""
                    color: "#03a9f5"
                    borderColor: "black"
                    axisY: axiYagr
                    axisX: axiXagr
                    onClicked: lineagr.state = false
                }
                Component.onCompleted: {
                    var xx = []
                    var yy = []
                    var yy1 = []
                    var yy2 = []
                    var max = 0
                    for(var i=0;i<count;i++){
                        xx[i] = Date.parse(array_dateX[i])
                        yy[i] = Number(array_valueY[i])
                        yy1[i] = Number(array_valueY1[i])
                        yy2[i] = Number(array_valueY2[i])
                        if(yy[i]>max){
                            max = yy[i]
                        }
                        if(yy1[i]>max){
                            max = yy1[i]
                        }
                        if(yy2[i]>max){
                            max = yy2[i]
                        }
                        lineagr.append(xx[i], yy[i])
                        line1agr.append(xx[i], yy1[i])
                        line2agr.append(xx[i], yy2[i])
                    }
                    oldX1 = xx[count-1]
                    oldY1 = yy1[count-1]
                    oldX2 = xx[count-1]
                    oldY2 = yy2[count-1]
                    oldX = xx[count-1]
                    oldY = yy[count-1]
                    scatter1agr.append(xx[count-1], yy1[count-1])
                    scatter2agr.append(xx[count-1], yy2[count-1])
                    scatteragr.append(xx[count-1], yy[count-1])
                    max = Math.round(max) + 1
                    axiYagr.max = max
                    //console.log(oldX,oldY)
                }
                function series_add(){
                    lineagr.clear()
                    line1agr.clear()
                    line2agr.clear()
                    scatteragr.clear()
                    scatter1agr.clear()
                    scatter2agr.clear()
                    chartIzmerAgr.update()
                    var xx = []
                    var yy = []
                    var yy1 = []
                    var yy2 = []
                    var max = 0
                    for(var i=0;i<count;i++){
                        xx[i] = Date.parse(array_dateX[i])
                        yy[i] = Number(array_valueY[i])
                        yy1[i] = Number(array_valueY1[i])
                        yy2[i] = Number(array_valueY2[i])
                        if(yy[i]>max){
                            max = yy[i]
                        }
                        if(yy1[i]>max){
                            max = yy1[i]
                        }
                        if(yy2[i]>max){
                            max = yy2[i]
                        }
                        lineagr.append(xx[i], yy[i])
                        line1agr.append(xx[i], yy1[i])
                        line2agr.append(xx[i], yy2[i])
                    }
                    oldX1 = xx[count-1]
                    oldY1 = yy1[count-1]
                    oldX2 = xx[count-1]
                    oldY2 = yy2[count-1]
                    oldX = xx[count-1]
                    oldY = yy[count-1]
                    scatter1agr.append(xx[count-1], yy1[count-1])
                    scatter2agr.append(xx[count-1], yy2[count-1])
                    scatteragr.append(xx[count-1], yy[count-1])
                    max = Math.round(max) + 1
                    axiYagr.max = max
                }
            }
            Flickable {
                id: flick
                visible: false
                anchors.top: rec_filter.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                ListView {
                    id: list
                    objectName: "list_stat"
                    property string tot
                    anchors.fill: parent
                    clip: true
                    model: model_stat
                    delegate: delegate
                    focus: true
                    headerPositioning: ListView.OverlayHeader
                    spacing: 2
                    //currentIndex: -1
                    //highlight: highlightBar
                    //highlightFollowsCurrentItem: false
                    ScrollBar.vertical: ScrollBar { id: vbar;
                                                hoverEnabled: true
                                                active: hovered || pressed
                                                orientation: Qt.Vertical
                                                //size: frame.height / content.height
                                                anchors.top: parent.top
                                                anchors.right: parent.right
                                                anchors.bottom: parent.bottom
                                                width: 10
                                    }
                }
                Component {
                    id: delegate
                    Item {
                        id: item_table
                        width: window.width
                        height: 200
                        Rectangle {
                            id: rec_item
                            width: parent.width
                            height: parent.height
                            //property var tot: model_stat.data(model_stat.index(1, 0), total)
                            property real otstup1: text_tipizmer_ekspl.width
                            property real otstup2: text_rezhim_rd.width
                            property real maximum: rec_total.width - text_total1.width - 10
                            property real maximum1: rec_tipizmer_ekspl.width - text_tipizmer_ekspl.width - text_tipizmer_ekspl1.width - 40
                            property real maximum2: rec_rezhim_rd.width - text_rezhim_rd.width - text_rezhim_rd1.width - 45
                            Component.onCompleted: console.log("tot", list.tot)

                            //color: "lightgrey"
                            Rectangle {
                                id: rec_kks
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                anchors.left: parent.left
                                anchors.leftMargin: 5
                                anchors.bottom: parent.bottom
                                width: parent.width/5
                                color: "#03a9f5"
                                Text {
                                    id: text_kks
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.pixelSize: 15
                                    //color: "white"
                                    text: kks
                                }
                            }
                            Rectangle {
                                id: rec_total
                                anchors.top: parent.top
                                anchors.left: rec_kks.right
                                height: parent.height/5
                                anchors.right: parent.right
                                color: "white"
                                Rectangle {
                                    id: rec_total1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: total/list.tot*rec_item.maximum//parent.width - text_total1.width - 10
                                    color: "#03a9f5"
                                }
                                Text {
                                    id: text_total1
                                    //property string tot1: tota
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_total1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text:  "всего " + total
                                }
                            }
                            Rectangle {
                                id: rec_tipizmer_ekspl
                                anchors.top: rec_total.bottom
                                anchors.left: rec_kks.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "lightblue"
                                Text {
                                    id: text_tipizmer_ekspl
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "Эксплуатация:"
                                }
                                Rectangle {
                                    id: rec_tipizmer_ekspl1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_tipizmer_ekspl.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: ekspl/total*rec_item.maximum1//parent.width - text_tipizmer_ekspl.width - text_tipizmer_ekspl1.width - 20
                                    color: "lightgreen"
                                }
                                Text {
                                    id: text_tipizmer_ekspl1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_tipizmer_ekspl1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: ekspl + " (" + (ekspl/total*100).toFixed(1) + "%)"
                                }
                            }
                            Rectangle {
                                id: rec_tipizmer_pnr
                                anchors.top: rec_tipizmer_ekspl.bottom
                                anchors.left: rec_kks.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "lightblue"
                                Text {
                                    id: text_tipizmer_pnr
                                    width: rec_item.otstup1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "ПНР:"
                                }
                                Rectangle {
                                    id: rec_tipizmer_pnr1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_tipizmer_pnr.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: pnr/total*rec_item.maximum1
                                    color: "lightgreen"
                                }
                                Text {
                                    id: text_tipizmer_pnr1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_tipizmer_pnr1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: pnr + " (" + (pnr/total*100).toFixed(1) + "%)"
                                }
                            }
                            Rectangle {
                                id: rec_tipizmer_ekspldop
                                anchors.top: rec_tipizmer_pnr.bottom
                                anchors.left: rec_kks.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "lightblue"
                                Text {
                                    id: text_tipizmer_ekspldop
                                    width: rec_item.otstup1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "Экспл. доп.:"
                                }
                                Rectangle {
                                    id: rec_tipizmer_ekspldop1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_tipizmer_ekspldop.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: ekspldop/total*rec_item.maximum1
                                    color: "lightgreen"
                                }
                                Text {
                                    id: text_tipizmer_ekspldop1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_tipizmer_ekspldop1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: ekspldop + " (" + (ekspldop/total*100).toFixed(1) + "%)"
                                }
                            }
                            Rectangle {
                                id: rec_tipizmer_pnrdop
                                anchors.top: rec_tipizmer_ekspldop.bottom
                                anchors.left: rec_kks.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "lightblue"
                                Text {
                                    id: text_tipizmer_pnrdop
                                    width: rec_item.otstup1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "ПНР доп.:"
                                }
                                Rectangle {
                                    id: rec_tipizmer_pnrdop1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_tipizmer_pnrdop.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: pnrdop/total*rec_item.maximum1
                                    color: "lightgreen"
                                }
                                Text {
                                    id: text_tipizmer_pnrdop1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_tipizmer_pnrdop1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: pnrdop + " (" + (pnrdop/total*100).toFixed(1) + "%)"
                                }
                            }
                            Rectangle {
                                id: rec_rezhim_nom
                                anchors.top: rec_total.bottom
                                anchors.left: rec_tipizmer_ekspl.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "tomato"
                                Text {
                                    id: text_rezhim_nom
                                    width: rec_item.otstup2
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "Номинальный:"
                                }
                                Rectangle {
                                    id: rec_rezhim_nom1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_rezhim_nom.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: nom/total*rec_item.maximum2
                                    color: "LightSkyBlue"
                                }
                                Text {
                                    id: text_rezhim_nom1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_rezhim_nom1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: nom + " (" + (nom/total*100).toFixed(1) + "%)"
                                }
                            }
                            Rectangle {
                                id: rec_rezhim_rd
                                anchors.top: rec_rezhim_nom.bottom
                                anchors.left: rec_tipizmer_ekspl.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "tomato"
                                Text {
                                    id: text_rezhim_rd
                                    //width: rec_item.otstup1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "Раб. диапазон:"
                                }
                                Rectangle {
                                    id: rec_rezhim_rd1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_rezhim_rd.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: rd/total*rec_item.maximum2
                                    color: "LightSkyBlue"
                                }
                                Text {
                                    id: text_rezhim_rd1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_rezhim_rd1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: rd + " (" + (rd/total*100).toFixed(1) + "%)"
                                }
                            }
                            Rectangle {
                                id: rec_rezhim_hh
                                anchors.top: rec_rezhim_rd.bottom
                                anchors.left: rec_tipizmer_ekspl.right
                                height: parent.height/5
                                width: parent.width*2/5
                                //color: "tomato"
                                Text {
                                    id: text_rezhim_hh
                                    width: rec_item.otstup2
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: "Холостой ход:"
                                }
                                Rectangle {
                                    id: rec_rezhim_hh1
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: text_rezhim_hh.right
                                    anchors.leftMargin: 5
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    width: hh/total*rec_item.maximum2
                                    color: "LightSkyBlue"
                                }
                                Text {
                                    id: text_rezhim_hh1
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: rec_rezhim_hh1.right
                                    anchors.leftMargin: 5
                                    font.pixelSize: 15
                                    text: hh + " (" + (hh/total*100).toFixed(1) + "%)"
                                }
                            }
                        }
                    }
                }










            }
        }//end rec1
        Rectangle {
            id: rec2
            anchors.top: rec1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            PathView {
                id: path
                    anchors.fill: parent
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    delegate: flipCardDelegate
                    model: objmodel
                    maximumFlickVelocity: 500
                    focus: true
                        Keys.onLeftPressed: decrementCurrentIndex()
                        Keys.onRightPressed: incrementCurrentIndex()
                    onMovementEnded: {
                        if(path.indexAt(path.width/2, path.height/2) === 0){
                            flick.visible = false
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerPersonal.visible = false
                            rec_filter.visible = false
                            text_personal.visible = false
                            combo_personal.visible = false
                            but_personal.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerDay.visible = false
                            chartIzmerMes.visible = false
                            chartIzmerHh.visible = false
                            chartKolAgr.visible = true
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 1){
                            flick.visible = false
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerHh.visible = false
                            chartIzmerPersonal.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerDay.visible = false
                            chartKolAgr.visible = false
                            chartIzmerMes.visible = true
                            rec_filter.visible = true
                            text_personal.visible = true
                            combo_personal.visible = true
                            but_personal.visible = true
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 2){
                            flick.visible = false
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerHh.visible = false
                            chartIzmerPersonal.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerMes.visible = false
                            chartKolAgr.visible = false
                            chartIzmerDay.visible = true
                            rec_filter.visible = true
                            text_personal.visible = true
                            combo_personal.visible = true
                            but_personal.visible = true
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 3){
                            flick.visible = false
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerHh.visible = false
                            chartIzmerPersonal.visible = false
                            chartIzmerMes.visible = false
                            chartKolAgr.visible = false
                            chartIzmerDay.visible = false
                            chartIzmerTime.visible = true
                            rec_filter.visible = true
                            text_personal.visible = true
                            combo_personal.visible = true
                            but_personal.visible = true
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 4){
                            flick.visible = false
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerMes.visible = false
                            chartKolAgr.visible = false
                            chartIzmerDay.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerPersonal.visible = true
                            rec_filter.visible = true
                            text_personal.visible = false
                            combo_personal.visible = false
                            but_personal.visible = false
                            chartIzmerHh.visible = false
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 5){
                            flick.visible = false
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerMes.visible = false
                            chartKolAgr.visible = false
                            chartIzmerDay.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerPersonal.visible = false
                            rec_filter.visible = true
                            text_personal.visible = false
                            combo_personal.visible = false
                            but_personal.visible = false
                            chartIzmerHh.visible = true
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 6){
                            flick.visible = false
                            chartIzmerAgr.visible = true
                            rec_filter.tipmeh_visible = true
                            chartIzmerMes.visible = false
                            chartKolAgr.visible = false
                            chartIzmerDay.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerPersonal.visible = false
                            rec_filter.visible = true
                            text_personal.visible = false
                            combo_personal.visible = false
                            but_personal.visible = false
                            chartIzmerHh.visible = false
                        }
                        if(path.indexAt(path.width/2, path.height/2) === 7){
                            flick.visible = true
                            chartIzmerAgr.visible = false
                            rec_filter.tipmeh_visible = false
                            chartIzmerMes.visible = false
                            chartKolAgr.visible = false
                            chartIzmerDay.visible = false
                            chartIzmerTime.visible = false
                            chartIzmerPersonal.visible = false
                            rec_filter.visible = true
                            text_personal.visible = false
                            combo_personal.visible = false
                            but_personal.visible = false
                            chartIzmerHh.visible = false
                        }
                    }

                    path: Path {
                        startX: 0//rec2.width/2
                        startY: rec2.height/2//0

                        PathAttribute { name: "itemZ"; value: 0 }
                        PathAttribute { name: "itemAngle"; value: -90.0; }
                        PathAttribute { name: "itemScale"; value: 0.5; }
                        PathLine { x: rec2.width*0.4; y: rec2.height/2; }
                        PathPercent { value: 0.48; }
                        PathLine { x: rec2.width*0.5; y: rec2.height/2; }
                        PathAttribute { name: "itemAngle"; value: 0.0; }
                        PathAttribute { name: "itemScale"; value: 1.0; }
                        PathAttribute { name: "itemZ"; value: 100 }
                        PathLine { x: rec2.width*0.6; y: rec2.height/2; }
                        PathPercent { value: 0.52; }
                        PathLine { x: rec2.width; y: rec2.height/2; }
                        PathAttribute { name: "itemAngle"; value: 90.0; }
                        PathAttribute { name: "itemScale"; value: 0.5; }
                        PathAttribute { name: "itemZ"; value: 0 }
                    }

                    pathItemCount: 10
                }
            ObjectModel {
                id: objmodel
                Rectangle {
                    id:rec00
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    color: "transparent"
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec00.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text00
                        z:1
                        anchors.bottom: chartKolAgr1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Количество агрегатов"
                    }
                    ChartView {
                        id: chartKolAgr1
                        //objectName: "chartKolAgr1"
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent

        dropShadowEnabled: true
                        BarSeries {
                            id: pie_series1
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxis1
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis { categories: chartKolAgr.array_nameagr
                            labelsVisible: false}
                        }
                        Component.onCompleted: {
                            //qmlKolAgr()
                            var kol = []
                            for(var i=0;i<chartKolAgr.razmer;i++){
                                kol[i] = parseInt(chartKolAgr.array_kolagr[i], 10)
                            }
                            yAxis1.max = Math.max.apply(null, kol)*1.1+1
                            var bar1 = pie_series1.append("label", kol)
                            //pie_series1.axisX.
                            //bar1.labelColor = "black"
                        }
                    }
                }
                Rectangle {
                    id:rec01
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    color: "transparent"
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec01.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text01
                        z:1
                        anchors.bottom: chartIzmerMes1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Измерения по месяцам"
                    }
                    ChartView {
                        id: chartIzmerMes1
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent
        dropShadowEnabled: true
                        BarSeries {
                            id: pie_seriesMes1
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxisMes1
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis { categories: chartIzmerMes.array_namemes
                            labelsAngle: -90
                            labelsVisible: false}
                        }
                        Component.onCompleted: {
                            var kol = []
                            for(var i=0;i<chartIzmerMes.razmer;i++){
                                kol[i] = parseInt(chartIzmerMes.array_kolmes[i], 10)
                            }
                            yAxisMes1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesMes1.append("label", kol)
                            bar.labelColor = "black"
                        }
                        function series_add(){
                            pie_seriesMes1.clear()
                            chartIzmerMes1.update()
                            var kol = []
                            for(var i=0;i<chartIzmerMes.razmer;i++){
                                kol[i] = parseInt(chartIzmerMes.array_kolmes[i], 10)
                            }
                            yAxisMes1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesMes1.append("label", kol)
                            bar.labelColor = "black"
                            console.log("kol = ", kol)
                        }
                    }
                }
                Rectangle {
                    id:rec02
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec02.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text02
                        z:1
                        anchors.bottom: chartIzmerDay1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Измерения по дням недели"
                    }
                    ChartView {
                        id: chartIzmerDay1
                        property var nameday: [7]
                        property var kolday: [7]
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent
        dropShadowEnabled: true
                        BarSeries {
                            id: pie_seriesDay1
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxisDay1
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis {id: category1
                                categories: chartIzmerDay.nameday
                            //labelsAngle: -90
                                labelsVisible: false
                            }
                        }
                        Component.onCompleted: {
                            nameday[0] = chartIzmerDay.array_nameday[1]
                            nameday[1] = chartIzmerDay.array_nameday[2]
                            nameday[2] = chartIzmerDay.array_nameday[3]
                            nameday[3] = chartIzmerDay.array_nameday[4]
                            nameday[4] = chartIzmerDay.array_nameday[5]
                            nameday[5] = chartIzmerDay.array_nameday[6]
                            nameday[6] = chartIzmerDay.array_nameday[0]
                            kolday[0] = chartIzmerDay.array_kolday[1]
                            kolday[1] = chartIzmerDay.array_kolday[2]
                            kolday[2] = chartIzmerDay.array_kolday[3]
                            kolday[3] = chartIzmerDay.array_kolday[4]
                            kolday[4] = chartIzmerDay.array_kolday[5]
                            kolday[5] = chartIzmerDay.array_kolday[6]
                            kolday[6] = chartIzmerDay.array_kolday[0]
                            var kol = []
                            for(var i=0;i<chartIzmerDay.razmer;i++){
                                kol[i] = parseInt(kolday[i], 10)
                            }
                            yAxisDay1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesDay1.append("label", kol)
                            category1.categories = nameday
                        }
                        function series_add(){
                            pie_seriesDay1.clear()
                            chartIzmerDay1.update()
                            kolday = [0,0,0,0,0,0,0]
                            for(var i=0;i<7;i++){
                                if(chartIzmerDay.array_nameday[i] === "Пн"){
                                    kolday[0] = chartIzmerDay.array_kolday[i]
                                }
                                if(chartIzmerDay.array_nameday[i] === "Вт"){
                                    kolday[1] = chartIzmerDay.array_kolday[i]
                                }
                                    if(chartIzmerDay.array_nameday[i] === "Ср"){
                                        kolday[2] = chartIzmerDay.array_kolday[i]
                                    }
                                        if(chartIzmerDay.array_nameday[i] === "Чт"){
                                            kolday[3] = chartIzmerDay.array_kolday[i]
                                        }
                                            if(chartIzmerDay.array_nameday[i] === "Пт"){
                                                kolday[4] = chartIzmerDay.array_kolday[i]
                                            }
                                                if(chartIzmerDay.array_nameday[i] === "Сб"){
                                                    kolday[5] = chartIzmerDay.array_kolday[i]
                                                }
                                                    if(chartIzmerDay.array_nameday[i] === "Вс"){
                                                        kolday[6] = chartIzmerDay.array_kolday[i]
                                                    }
                            }
                            var kol = []
                            for(var i=0;i<7;i++){
                                kol[i] = parseInt(kolday[i], 10)
                            }
                            yAxisDay1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesDay1.append("label", kol)
                            bar.labelColor = "black"
                        }
                    }
                }
                Rectangle {
                    id:rec03
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec03.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text03
                        z:1
                        anchors.bottom: chartIzmerTime1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Измерения по часам"
                    }
                    ChartView {
                        id: chartIzmerTime1
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent
        dropShadowEnabled: true
                        BarSeries {
                            id: pie_seriesTime1
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxisTime1
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis {id: category3
                                categories: ["00-01","01-02","02-03","03-04","04-05","05-06","06-07","07-08","08-09","09-10","10-11","11-12",
                                    "12-13","13-14","14-15","15-16","16-17","17-18","18-19","19-20","20-21","21-22","22-23","23-24"]
                            //labelsAngle: -90
                                labelsVisible: false
                            }
                        }
                        Component.onCompleted: {
                            var kol = []
                            for(var i=0;i<24;i++){
                                kol[i] = parseInt(chartIzmerTime.array_koltime[i], 10)
                            }
                            yAxisTime1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesTime1.append("label", kol)
                        }
                        function series_add(){
                            pie_seriesTime1.clear()
                            chartIzmerTime1.update()
                            var kol = []
                            for(var i=0;i<24;i++){
                                kol[i] = parseInt(chartIzmerTime.array_koltime[i], 10)
                            }
                            yAxisTime1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesTime1.append("label", kol)
                            bar.labelColor = "black"
                        }
                    }
                }
                Rectangle {
                    id:rec04
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec04.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text04
                        z:1
                        anchors.bottom: chartIzmerPersonal1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Измерения персоналом"
                    }
                    ChartView {
                        id: chartIzmerPersonal1
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent
        dropShadowEnabled: true
                        BarSeries {
                            id: pie_seriesPersonal1
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxisPersonal1
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis {id: categorypersonal1
                                categories: rec_filter.personal
                            //labelsAngle: -90
                            labelsVisible: false
                            }
                        }
                        Component.onCompleted: {
                            var kol = []
                            for(var i=0;i<rec_filter.razmer;i++){
                                kol[i] = parseInt(chartIzmerPersonal.array_kolpersonal[i], 10)
                            }
                            yAxisPersonal1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesPersonal1.append("label", kol)
                            bar.labelColor = "black"
                        }
                        function series_add(){
                            pie_seriesPersonal1.clear()
                            chartIzmerPersonal1.update()
                            var kol = []
                            for(var i=0;i<rec_filter.razmer;i++){
                                kol[i] = parseInt(chartIzmerPersonal.array_kolpersonal[i], 10)
                            }
                            console.log("koltime = ", kol)
                            yAxisPersonal1.max = Math.round(Math.max.apply(null, kol)*1.1)+1
                            var bar = pie_seriesPersonal1.append("label", kol)
                            bar.labelColor = "black"
                        }
                    }
                }
                Rectangle {
                    id:rec05
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec05.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text05
                        z:1
                        anchors.bottom: chartIzmerHh1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Измерения на х/х"
                    }
                    ChartView {
                        id: chartIzmerHh1
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent
        dropShadowEnabled: true
                        ValueAxis {
                            id: axiY1
                            min: 0
                            labelsVisible: false
                        }
                        DateTimeAxis {
                            id: axiX1
                            format: "dd-MM-yyyy"
                            min: rec_filter.date_begin
                            max: rec_filter.date_end
                            labelsVisible: false
                        }
                        LineSeries {
                            id: line11
                            color: "lightgreen"
                            axisY: axiY1
                            axisX: axiX1
                            width: 2
                        }
                        LineSeries {
                            id: line21
                            color: "tomato"
                            axisY: axiY1
                            axisX: axiX1
                            //opacity: 0.5
                            width: 2
                        }
                        LineSeries {
                            id: line01
                            color: "#03a9f5"
                            axisY: axiY1
                            axisX: axiX1
                            width: 2
                        }
                        Component.onCompleted: {
                            var xx = []
                            var yy = []
                            var yy1 = []
                            var yy2 = []
                            var max = 0
                            for(var i=0;i<chartIzmerHh.count;i++){
                                xx[i] = Date.parse(chartIzmerHh.array_dateX[i])
                                yy[i] = Number(chartIzmerHh.array_valueY[i])
                                yy1[i] = Number(chartIzmerHh.array_valueY1[i])
                                yy2[i] = Number(chartIzmerHh.array_valueY2[i])
                                if(yy[i]>max){
                                    max = yy[i]
                                }
                                if(yy1[i]>max){
                                    max = yy1[i]
                                }
                                if(yy2[i]>max){
                                    max = yy2[i]
                                }
                                line01.append(xx[i], yy[i])
                                line11.append(xx[i], yy1[i])
                                line21.append(xx[i], yy2[i])
                            }
                            max = Math.round(max) + 1
                            axiY1.max = max
                        }
                    }
                }
                Rectangle {
                    id:rec06
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec06.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text06
                        z:1
                        anchors.bottom: chartIzmerAgr1.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        color: "#03a9f5"
                        text: "Измерения в сборе"
                    }
                    ChartView {
                        id: chartIzmerAgr1
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent
        dropShadowEnabled: true
                        ValueAxis {
                            id: axiYagr1
                            min: 0
                            labelsVisible: false
                        }
                        DateTimeAxis {
                            id: axiXagr1
                            format: "dd-MM-yyyy"
                            min: rec_filter.date_begin
                            max: rec_filter.date_end
                            labelsVisible: false
                        }
                        LineSeries {
                            id: line1agr1
                            color: "lightgreen"
                            axisY: axiYagr1
                            axisX: axiXagr1
                            width: 2
                        }
                        LineSeries {
                            id: line2agr1
                            color: "tomato"
                            axisY: axiYagr1
                            axisX: axiXagr1
                            width: 2
                        }
                        LineSeries {
                            id: lineagr1
                            color: "#03a9f5"
                            axisY: axiYagr1
                            axisX: axiXagr1
                            width: 2
                        }
                        Component.onCompleted: {
                            var xx = []
                            var yy = []
                            var yy1 = []
                            var yy2 = []
                            var max = 0
                            for(var i=0;i<chartIzmerAgr.count;i++){
                                xx[i] = Date.parse(chartIzmerAgr.array_dateX[i])
                                yy[i] = Number(chartIzmerAgr.array_valueY[i])
                                yy1[i] = Number(chartIzmerAgr.array_valueY1[i])
                                yy2[i] = Number(chartIzmerAgr.array_valueY2[i])
                                if(yy[i]>max){
                                    max = yy[i]
                                }
                                if(yy1[i]>max){
                                    max = yy1[i]
                                }
                                if(yy2[i]>max){
                                    max = yy2[i]
                                }
                                lineagr1.append(xx[i], yy[i])
                                line1agr1.append(xx[i], yy1[i])
                                line2agr1.append(xx[i], yy2[i])
                            }
                            max = Math.round(max) + 1
                            axiYagr1.max = max
                            //console.log(oldX,oldY)
                        }
                        function series_add(){
                            lineagr1.clear()
                            line1agr1.clear()
                            line2agr1.clear()
                            chartIzmerAgr1.update()
                            var xx = []
                            var yy = []
                            var yy1 = []
                            var yy2 = []
                            var max = 0
                            for(var i=0;i<chartIzmerAgr.count;i++){
                                xx[i] = Date.parse(chartIzmerAgr.array_dateX[i])
                                yy[i] = Number(chartIzmerAgr.array_valueY[i])
                                yy1[i] = Number(chartIzmerAgr.array_valueY1[i])
                                yy2[i] = Number(chartIzmerAgr.array_valueY2[i])
                                if(yy[i]>max){
                                    max = yy[i]
                                }
                                if(yy1[i]>max){
                                    max = yy1[i]
                                }
                                if(yy2[i]>max){
                                    max = yy2[i]
                                }
                                lineagr1.append(xx[i], yy[i])
                                line1agr1.append(xx[i], yy1[i])
                                line2agr1.append(xx[i], yy2[i])
                            }
                            max = Math.round(max) + 1
                            axiYagr1.max = max
                        }
                    }
                }
                Rectangle {
                    id:rec08
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec08.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text08
                        z:1
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        text: "Количество агрегатов"
                    }
                    ChartView {
                        id: chartKolAgr8
                        //objectName: "chartKolAgr1"
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent

        dropShadowEnabled: true
                        BarSeries {
                            id: pie_series8
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxis8
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis { categories: chartKolAgr.array_nameagr
                            labelsVisible: false}
                        }
                        Component.onCompleted: {
                            //qmlKolAgr()
                            var kol = []
                            for(var i=0;i<chartKolAgr.razmer;i++){
                                kol[i] = parseInt(chartKolAgr.array_kolagr[i], 10)
                            }
                            yAxis8.max = Math.max.apply(null, kol)*1.1
                            var bar8 = pie_series8.append("label", kol)
                            //pie_series1.axisX.
                            //bar1.labelColor = "black"
                        }
                    }
                }
                Rectangle {
                    id:rec09
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec09.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text09
                        z:1
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        text: "Количество агрегатов"
                    }
                    ChartView {
                        id: chartKolAgr9
                        //objectName: "chartKolAgr1"
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent

        dropShadowEnabled: true
                        BarSeries {
                            id: pie_series9
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxis9
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis { categories: chartKolAgr.array_nameagr
                            labelsVisible: false}
                        }
                        Component.onCompleted: {
                            //qmlKolAgr()
                            var kol = []
                            for(var i=0;i<chartKolAgr.razmer;i++){
                                kol[i] = parseInt(chartKolAgr.array_kolagr[i], 10)
                            }
                            yAxis9.max = Math.max.apply(null, kol)*1.1
                            var bar9 = pie_series9.append("label", kol)
                            //pie_series1.axisX.
                            //bar1.labelColor = "black"
                        }
                    }
                }
                Rectangle {
                    id:rec10
                    width: rec2.height*1.5
                    height: rec2.height*0.9
                    visible: PathView.onPath
                    scale: PathView.itemScale
                    z: PathView.itemZ
                    property variant rotY: PathView.itemAngle
                    transform: Rotation {
                        axis { x: 1; y: -1; z: 1 }
                        angle: rec10.rotY;
                        origin { x: rec2.height/2; y: rec2.height/2; }
                    }
                    Text {
                        id: text10
                        z:1
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height/5
                        text: "Количество агрегатов"
                    }
                    ChartView {
                        id: chartKolAgr10
                        //objectName: "chartKolAgr1"
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        margins.bottom: 0
                        margins.left: 0
                        margins.right: 0
                        margins.top: 0
                        anchors.centerIn: parent

        dropShadowEnabled: true
                        BarSeries {
                            id: pie_series10
                            labelsVisible: false
                            labelsPosition: AbstractBarSeries.LabelsOutsideEnd
                            axisY: ValueAxis {
                                id: yAxis10
                                        min: 0
                                        max: 10
                                        labelsVisible: false
                            }
                            axisX: BarCategoryAxis { categories: chartKolAgr.array_nameagr
                            labelsVisible: false}
                        }
                        Component.onCompleted: {
                            //qmlKolAgr()
                            var kol = []
                            for(var i=0;i<chartKolAgr.razmer;i++){
                                kol[i] = parseInt(chartKolAgr.array_kolagr[i], 10)
                            }
                            yAxis10.max = Math.max.apply(null, kol)*1.1
                            var bar10 = pie_series10.append("label", kol)
                            //pie_series1.axisX.
                            //bar1.labelColor = "black"
                        }
                    }
                }
            }//end objmodel


            Component {
                    id: flipCardDelegate
                    Rectangle {
                        id: wrapper
                        width: rec2.height*1.5
                        height: rec2.height*0.9
                    }
                }
        }
    }
}
}