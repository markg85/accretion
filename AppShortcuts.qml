import QtQuick 2.1
import kdirchainmodel 1.0

/**
  This file defines components that should only be added once.
 */

Item {
    // Clipboard
    //Clipboard { id: clip }

    // refresh
    Shortcut {
        key: "F5"
        onActivated: {
            console.log("JS: " + key + " pressed.")
        }
    }

    // copy
    Shortcut {
        key: "Ctrl+C"
        id: test
        onActivated: {
            console.log("JS: " + key + " pressed.")
        }
    }

    // cut
    Shortcut {
        key: "Ctrl+X"
        onActivated: {
            console.log("JS: " + key + " pressed.")
        }
    }

    // paste
    Shortcut {
        key: "Ctrl+V"
        onActivated: {
            console.log("JS: " + key + " pressed.")
        }
    }
}
