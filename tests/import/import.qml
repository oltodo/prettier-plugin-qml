import   QtQuick 2.5
import QtQuick.Window   2.2 as   Window   
import   "path/to/library.js  " as Library
import "   path/to/components"

Rectangle {
    property var helloWorld

    property var veryLongValueProperty: ApplaunchService.Service.getInstance().maintenance['enable']

       property var someNumber: {
           1.5
       }
    property  var someList: [1, 2, 'three', "four"]
    property var someObject: Rectangle { width: 100; height: 100; color: 'red' 
    
    }
    property color   someColor:   "blue"

    // Default property
    default property var someString: "abc"

    // Read-only property
    readonly property var   someBool: true

    property   list<Rectangle> siblingRects

    property list<Rectangle> childRects: [
        Rectangle { color: "red" },
        Rectangle { color: "blue"}
    ]

    function foobar() {
        console.log ('foobar');
    }

    Rectangle {
        id: foobar
        
    }



}
