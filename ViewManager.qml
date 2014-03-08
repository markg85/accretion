import QtQuick 2.1

Item {
    property ViewContainer activeView: undefined

    function registerView(view) {
        if(!activeView) {
            activeView = view
            activeView.activeView = true
        } else {
            view.activeView = false
        }
    }

    function reload() {
        if(activeView) {
            activeView.reload()
        }
    }

    function toggleFilter() {
        if(activeView) {
            activeView.toggleFilter()
        }
    }

    function hideFilter() {
        if(activeView) {
            activeView.hideFilter()
        }
    }

    function setActive(view) {
        if(view) {
            if(view != activeView) {
                activeView.activeView = false
            }

            activeView = view
            activeView.activeView = true
        }
    }
}
