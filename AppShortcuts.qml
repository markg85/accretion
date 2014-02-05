import QtQuick 2.1
import kdirchainmodel 1.0

/**
  This file defines components that should only be added once.
 */

Item {
    id: root
    // Clipboard
    //Clipboard { id: clip }

    signal splitViewActivated()
    signal reload()
    signal cut()
    signal copy()
    signal paste()
    signal back()
    signal forward()
    signal filter()
    signal esc()

    // refresh
    Shortcut {
        keys: [ "F5", "Ctrl+R" ]
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.reload()
        }
    }

    // copy
    Shortcut {
        keys: "Ctrl+C"
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.copy()
        }
    }

    // cut
    Shortcut {
        keys: "Ctrl+X"
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.cut()
        }
    }

    // paste
    Shortcut {
        keys: "Ctrl+V"
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.paste()
        }
    }

    // Toggle splitview
    Shortcut {
        keys: "F3"
        onActivated: {
            root.splitViewActivated()
        }
    }

    // back
    Shortcut {
        keys: [ "BackButton", "Alt+Left", "Backspace" ]
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.back()
        }
    }

    // forward
    Shortcut {
        keys: [ "ForwardButton", "Alt+Right" ]
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.forward()
        }
    }

    // Filter (initiate filter in currently active view)
    Shortcut {
        keys: "Ctrl+i"
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.filter()
        }
    }

    // Escape (cancel input fields.. those kind of things.
    Shortcut {
        keys: "Esc"
        onActivated: {
            console.log("JS: " + keys + " pressed.")
            root.esc()
        }
    }
}
