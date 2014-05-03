import QtQuick 2.1

Item {
    property ViewContainer activeView: undefined
    property ViewContainer lastInactiveView: undefined
    property string defaultUrl: ""
    property bool blockCreation: false

    function registerView(view) {
        if(!activeView) {
            activeView = view
            activeView.activeView = true
            activeView.url = defaultUrl
        } else {
            view.activeView = false
            view.url = activeView.url
            lastInactiveView = view
        }
    }

    function addViewContainer() {
        if(blockCreation) {
            return;
        }

        blockCreation = true
        var incubator = viewContainerComp.incubateObject(splitView)
        if (incubator.status != Component.Ready) {
            incubator.onStatusChanged = function(status) {
                if (status == Component.Ready) {
                    blockCreation = false
                }
            }
        } else {
            blockCreation = false
        }
    }

    function splitViewToggle() {
        if(lastInactiveView) {
            lastInactiveView.destroy()
            lastInactiveView = null
        } else {
            addViewContainer()
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

            lastInactiveView = activeView
            activeView = view
            activeView.activeView = true
        }
    }

    function toggleGrouping() {
        if(activeView) {
            activeView.toggleGrouping()
        }
    }
}
